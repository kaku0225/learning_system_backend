module Types
  class BranchSchoolType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :code, String, null: false
    field :phone, String, null: false
    field :address, String, null: false
    field :enabled, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :users, [Types::UserType]
  end
end
