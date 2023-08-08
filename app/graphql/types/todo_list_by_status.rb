module Types
  class TodoListByStatus < Types::BaseObject
    field :pending_todo_lists, [Types::TodoListType], null: false
    field :done_todo_lists, [Types::TodoListType], null: false
  end
end
