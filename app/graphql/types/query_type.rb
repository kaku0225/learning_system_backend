module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :exam_countdown, Types::ExamCountdownType, null: false

    def exam_countdown
      s_exam = '2023-08-31'
      c_exam = '2024-04-01'

      { sectional_exam: (s_exam.to_time.to_i - Time.current.to_i) * 1000, comprehensive_assessment_program: (c_exam.to_time.to_i - Time.current.to_i) * 1000 }
    end

    field :todo_list, [Types::TodoListType], null: false do
      argument :token, String, required: true
      argument :status, String, required: true
    end

    def todo_list(token:, status:)
      decoded_token = JWT.decode token, Settings.jwt_hmac_secret, true, { algorithm: 'HS256' }
      user = ::User.find_by(email: decoded_token[0]['email'])
      user.todo_lists.where(status: status)
    end
  end
end
