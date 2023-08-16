class TodoList < ApplicationRecord
  belongs_to :student

  enum status: { pending: 0, done: 1 }
end
