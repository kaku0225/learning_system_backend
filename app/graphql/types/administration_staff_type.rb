module Types
  class AdministrationStaffType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :jti, String, null: false
    field :expired_time, GraphQL::Types::ISO8601DateTime, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :enabled, Boolean
    field :profile, Types::TeacherProfileType, null: false
    field :branch_schools, [Types::BranchSchoolType]
  end
end
