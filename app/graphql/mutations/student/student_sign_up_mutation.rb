module Mutations
  module Student
    class StudentSignUpMutation < Mutations::BaseMutation
      argument :info, Types::Inputs::UserInputType, required: true
      argument :profile, Types::Inputs::StudentProfileInputType, required: true
      argument :branch_schools, [String], required: true

      field :student, Types::StudentType
      field :success, Boolean, null: false
      field :message, String

      def resolve(params)
        ::Student.transaction do
          student = build_student(params)
          student.create_or_update_password = true
          student.save!
          { success: true, student: student }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, message: e.record.errors.full_messages.join('、 ') }
        end
      end

      private

      def build_student(params)
        student = ::Student.new(params[:info].to_h)
        student.jti = generate_jti(params[:info][:email])
        student.build_profile(params[:profile].to_h)
        student.branch_schools = find_branch_schools(params[:branch_schools])
        student
      end

      def generate_jti(email)
        JWT.encode({ email: email }, Settings.jwt_hmac_secret, 'HS256')
      end

      def find_branch_schools(names)
        BranchSchool.where(name: names)
      end
    end
  end
end
