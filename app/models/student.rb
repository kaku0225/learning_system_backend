class Student < User
  has_one :profile, class_name: 'StudentProfile', inverse_of: :student, dependent: :destroy, autosave: true
end
