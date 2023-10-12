module Mutations
  module Student
    class StudentUpdateByClassAdviserMutation < Mutations::BaseMutation
      argument :id, String, required: true
      argument :name, String, required: true
      argument :email, String, required: true
      argument :profile, Types::Inputs::StudentProfileInputType, required: true
      argument :branch_schools, [String], required: true

      field :students, [Types::StudentType]
      field :success, Boolean, null: false
      field :message, String

      def resolve(params)
        student = ::Student.find(params[:id])
        update_student(student, params)
        { success: true, students: ::Student.includes(:profile, :branch_schools).order(id: :desc) }
      rescue ActiveRecord::RecordNotFound => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      rescue ActiveRecord::RecordInvalid => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      end

      private

      def update_student(student, params)
        ::Student.transaction do
          student.assign_attributes(name: params[:name], email: params[:email])
          student.profile.assign_attributes(params[:profile].to_h)
          student.branch_schools = ::BranchSchool.where(name: params[:branch_schools])
          student.save!
        end
      end
    end
  end
end
