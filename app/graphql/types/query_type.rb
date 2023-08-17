module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :check_login, Types::CheckLoginType, null: false do
      argument :token, String, required: true
      argument :role, String, required: true
    end

    def check_login(token:, role:)
      user = ::User.find_by(jti: token)
      return { success: false } if user.blank?

      if expired_token?(token)
        { success: false }
      elsif user.type != role
        { success: true, path: Settings.check_login.path.send(user.type) }
      else
        { success: true }
      end
    end

    field :exam_countdown, Types::ExamCountdownType, null: false

    def exam_countdown
      s_exam = '2023-09-18'
      c_exam = '2024-04-01'

      { sectional_exam: (s_exam.to_time.to_i - Time.current.to_i) * 1000, comprehensive_assessment_program: (c_exam.to_time.to_i - Time.current.to_i) * 1000 }
    end

    field :todo_list_by_status, Types::TodoListByStatus, null: false do
      argument :token, String, required: true
    end

    def todo_list_by_status(token:)
      decoded_token = JWT.decode token, Settings.jwt_hmac_secret, true, { algorithm: 'HS256' }
      student = ::Student.find_by(email: decoded_token[0]['email'])
      if student.present?
        { pending_todo_lists: student.todo_lists.where(status: 'pending'), done_todo_lists: student.todo_lists.where(status: 'done') }
      else
        { pending_todo_lists: [],  done_todo_lists: []}
      end
    end


    private

    def expired_token?(token)
      decoded_token = JWT.decode token, Settings.jwt_hmac_secret, true, { algorithm: 'HS256' }
      decoded_token[0]['expired'] < Time.current
    end
  end
end
