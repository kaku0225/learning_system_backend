module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :jti, String, null: false
    field :expired_time, GraphQL::Types::ISO8601DateTime, null: false
    field :reset_jti, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :birthday, String, null: false
    field :cellphone, String, null: false
    field :phone, String, null: false
    field :school, String, null: false
    field :main_grade, String, null: false
    field :sub_grade, String, null: false
    field :county, String, null: false
    field :address, String, null: false
    field :branch_school, String, null: false

    field :todo_lists, [Types::TodoListType], null: true
  end
end
