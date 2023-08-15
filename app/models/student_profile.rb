class StudentProfile < ApplicationRecord
  belongs_to :student, inverse_of: :profile
  validates :student, presence: true
end
