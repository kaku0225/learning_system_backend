class TeacherProfile < ApplicationRecord
  belongs_to :teacher, inverse_of: :profile
  validates :teacher, presence: true
end
