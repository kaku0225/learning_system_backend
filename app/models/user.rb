class User < ApplicationRecord
  include BCrypt
  has_secure_password

  has_many :todo_lists
  has_many :assigns, class_name: 'TodoList', foreign_key: :assign_id
end
