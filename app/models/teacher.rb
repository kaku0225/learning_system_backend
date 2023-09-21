class Teacher < User
  has_one :profile, class_name: 'TeacherProfile', inverse_of: :teacher, dependent: :destroy, autosave: true
end
