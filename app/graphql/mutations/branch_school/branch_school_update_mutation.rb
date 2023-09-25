module Mutations
  module BranchSchool
    class BranchSchoolUpdateMutation < Mutations::BaseMutation
      argument :id, String, required: true
      argument :name, String, required: true
      argument :phone, String, required: true
      argument :address, String, required: true
      argument :enabled, Boolean, required: true
      argument :code, String, required: true

      field :branch_schools, [Types::BranchSchoolType]
      field :success, Boolean, null: false
      field :message, String

      def resolve(id:, **argument)
        branch_school = ::BranchSchool.find(id)
        update_branch_school(branch_school, argument)
        { success: true, branch_schools: ::BranchSchool.includes(:users) }
      rescue ActiveRecord::RecordNotFound => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      rescue ActiveRecord::RecordInvalid => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      end

      private

      def update_branch_school(branch_school, argument)
        ::BranchSchool.transaction do
          branch_school.assign_attributes(argument)
          branch_school.save!
        end
      end
    end
  end
end
