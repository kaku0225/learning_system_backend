module Types
  class StudentType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :jti, String, null: false
    field :expired_time, GraphQL::Types::ISO8601DateTime, null: false
    field :reset_jti, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :enabled, Boolean, default: false
    field :profile, Types::StudentProfileType, null: false
    field :todo_lists, [Types::TodoListType], null: true
  end
end
