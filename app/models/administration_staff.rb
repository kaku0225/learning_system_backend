class AdministrationStaff < User
  has_one :profile, class_name: 'AdministrationStaffProfile', inverse_of: :administration_staff, dependent: :destroy, autosave: true
end
