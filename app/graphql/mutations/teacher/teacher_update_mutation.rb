module Mutations
  module Teacher
    class TeacherUpdateMutation < Mutations::BaseMutation
      argument :id, String, required: true
      argument :name, String, required: true
      argument :email, String, required: true
      argument :gender, String, required: true
      argument :cellphone, String, required: true
      argument :school, String, required: true
      argument :major, String, required: true
      argument :branch_schools, [String], required: true
      argument :subjects, [String], required: true

      field :teachers, [Types::TeacherType]
      field :success, Boolean, null: false
      field :message, String

      def resolve(id:, name:, email:, subjects:, branch_schools:, **profile_attributes)
        teacher = ::Teacher.find(id)
        update_teacher(teacher, name, email, subjects, branch_schools, profile_attributes)
        { success: true, teachers: ::Teacher.includes(:profile, :branch_schools) }
      rescue ActiveRecord::RecordNotFound => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      rescue ActiveRecord::RecordInvalid => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      end

      private

      def update_teacher(teacher, name, email, subjects, branch_schools, profile_attributes)
        ::Teacher.transaction do
          teacher.assign_attributes(name: name, email: email)
          teacher.profile.assign_attributes(profile_attributes)
          teacher.subjects = ::Subject.where(name: subjects)
          teacher.branch_schools = ::BranchSchool.where(name: branch_schools)
          teacher.save!
        end
      end
    end
  end
end
