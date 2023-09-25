module Mutations
  module AdministrationStaff
    class AdministrationStaffUpdateMutation < Mutations::BaseMutation
      argument :id, String, required: true
      argument :name, String, required: true
      argument :email, String, required: true
      argument :gender, String, required: true
      argument :cellphone, String, required: true
      argument :school, String, required: true
      argument :major, String, required: true
      argument :branch_schools, [String], required: true

      field :administration_staffs, [Types::AdministrationStaffType]
      field :success, Boolean, null: false
      field :message, String

      def resolve(id:, name:, email:, branch_schools:, **profile_attributes)
        administration_staff = ::AdministrationStaff.find(id)
        update_administration_staff(administration_staff, name, email, branch_schools, profile_attributes)
        { success: true, administration_staffs: ::AdministrationStaff.includes(:profile, :branch_schools) }
      rescue ActiveRecord::RecordNotFound => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      rescue ActiveRecord::RecordInvalid => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      end

      private

      def update_administration_staff(administration_staff, name, email, branch_schools, profile_attributes)
        ::AdministrationStaff.transaction do
          administration_staff.assign_attributes(name: name, email: email)
          administration_staff.profile.assign_attributes(profile_attributes)
          administration_staff.branch_schools = BranchSchool.where(name: branch_schools)
          administration_staff.save!
        end
      end
    end
  end
end
