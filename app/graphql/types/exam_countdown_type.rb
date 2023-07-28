module Types
  class ExamCountdownType < Types::BaseObject
    field :sectional_exam, GraphQL::Types::BigInt, null: false
    field :comprehensive_assessment_program, GraphQL::Types::BigInt, null: false
  end
end
