class Teacher < User
  has_one :profile, class_name: 'TeacherProfile', inverse_of: :teacher, dependent: :destroy, autosave: true

  has_many :teacher_subjects
  has_many :subjects, through: :teacher_subjects

  has_many :schedules
end
