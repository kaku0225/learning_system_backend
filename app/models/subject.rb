class Subject < ApplicationRecord
  has_many :teacher_subjects
  has_many :teachers, through: :teacher_subjects, class_name: 'Teacher'
end
