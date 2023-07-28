module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :exam_countdown, Types::ExamCountdownType, null: false

    def exam_countdown
      s_exam = '2023-07-31'
      c_exam = '2024-04-01'

      { sectional_exam: (s_exam.to_time.to_i - Time.current.to_i) * 1000, comprehensive_assessment_program: (c_exam.to_time.to_i - Time.current.to_i) * 1000 }
    end
  end
end
