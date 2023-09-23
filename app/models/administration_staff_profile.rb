class AdministrationStaffProfile < ApplicationRecord
  belongs_to :administration_staff, inverse_of: :profile
  validates :administration_staff, presence: true
end
