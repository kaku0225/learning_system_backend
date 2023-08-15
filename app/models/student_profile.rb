class StudentProfile < ApplicationRecord
  belongs_to :student, inverse_of: :companion
  validates :student, presence: true
end
