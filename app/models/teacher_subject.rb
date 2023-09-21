class TeacherSubject < ApplicationRecord
  belongs_to :teacher, class_name: 'Teacher', foreign_key: :teacher_id
  belongs_to :subject
end
