module Mutations
  module Admin
    class BranchSchoolCreateMutation < Mutations::BaseMutation
      argument :name, String, required: true
      argument :phone, String, required: true
      argument :address, String, required: true
      argument :enabled, Boolean, required: true
      argument :code, String, required: true

      field :branch_schools, [Types::BranchSchoolType]
      field :success, Boolean, null: false
      field :message, String

      def resolve(**argument)
        branch_school = ::BranchSchool.new(argument)
        branch_school.save!
        { success: true, branch_schools: ::BranchSchool.includes(:users).where(users: { type: 'ClassAdviser' }) }
      rescue ActiveRecord::RecordInvalid => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      end
    end
  end
end
