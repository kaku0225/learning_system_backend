class Teacher < User
  has_one :profile, class_name: 'TeacherProfile', inverse_of: :teacher, dependent: :destroy, autosave: true

  has_many :teacher_subjects, foreign_key: :teacher_id
  has_many :subjects, through: :teacher_subjects
end
