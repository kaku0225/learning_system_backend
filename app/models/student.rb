class Student < User
  has_one :profile, class_name: 'StudentProfile', inverse_of: :student, dependent: :destroy, autosave: true

  has_many :todo_lists
  has_many :assigns, class_name: 'TodoList', foreign_key: :assign_id
end
