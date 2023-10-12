module Mutations
  module Student
    class SwitchEnabledMutation < Mutations::BaseMutation
      argument :id, String, required: true

      field :students, [Types::StudentType]
      field :success, Boolean, null: false
      field :message, String

      def resolve(id:)
        student = ::Student.find(id)
        student.update(enabled: !student.enabled)
        { success: true, students: ::Student.includes(:profile, :branch_schools).order(id: :desc) }
      rescue ActiveRecord::RecordNotFound => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      end
    end
  end
end
