module Types
  class TeacherType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :jti, String, null: false
    field :expired_time, GraphQL::Types::ISO8601DateTime, null: false
    field :reset_jti, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :enabled, Boolean
    field :profile, Types::TeacherProfileType, null: false
    field :subjects, [Types::SubjectType]
    field :schedules, [Types::ScheduleType]
    field :branch_schools, [Types::BranchSchoolType]
  end
end
