class TodoList < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, done: 1 }
end
