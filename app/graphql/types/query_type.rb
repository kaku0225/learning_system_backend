module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :check_login, Boolean, null: false do
      argument :token, String, required: true
    end

    def check_login(token:)
      if ::User.where(jti: token).present?
        decoded_token = JWT.decode token, Settings.jwt_hmac_secret, true, { algorithm: 'HS256' }
        decoded_token[0]['expired'] > Time.current
      else
        false
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
      user = ::User.find_by(email: decoded_token[0]['email'])

      { pending_todo_lists: user.todo_lists.where(status: 'pending'), done_todo_lists: user.todo_lists.where(status: 'done') }
    end
  end
end
