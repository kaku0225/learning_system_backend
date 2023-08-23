module Mutations
  module Student
    class StudentSignUpMutation < Mutations::BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
      argument :birthday, String, required: true
      argument :cellphone, String, required: true
      argument :phone, String, required: true
      argument :school, String, required: true
      argument :main_grade, String, required: true
      argument :sub_grade, String, required: true
      argument :county, String, required: true
      argument :address, String, required: true
      argument :branch_school, String, required: true

      field :student, Types::StudentType
      field :success, Boolean, null: false
      field :message, String

      def resolve(name:, email:, password:, password_confirmation:, **profile_attributes)
        ::Student.transaction do
          student = ::Student.new(name: name, email: email, password: password, password_confirmation: password_confirmation, jti: JWT.encode({ email: email }, Settings.jwt_hmac_secret, 'HS256'))
          student.build_profile(profile_attributes)
          student.save!
          { success: true, student: student }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, message: e.record.errors.full_messages.join('、 ') }
        end
      end
    end
  end
end
