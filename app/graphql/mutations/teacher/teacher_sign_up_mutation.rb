module Mutations
  module Teacher
    class TeacherSignUpMutation < Mutations::BaseMutation
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

      def resolve(name:, email:, subjects:, branch_schools:, **profile_attributes)
        password = generate_random_password

        begin
          create_teacher(name, email, password, subjects, branch_schools, profile_attributes)
          ContactMailer.temp_password(email, password).deliver_later
          { success: true, teachers: ::Teacher.includes(:profile, :subjects, :branch_schools) }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, message: e.record.errors.full_messages.join('、 ') }
        end
      end

      private

      def generate_random_password
        [
          [*'A'..'Z'].sample,
          [*'a'..'z'].sample,
          [*'0'..'9'].sample,
          *[*('a'..'z'), *('0'..'9'), *('A'..'Z')].sample(5)
        ].shuffle.join
      end

      def create_teacher(name, email, password, subjects, branch_schools, profile_attributes)
        ::Teacher.transaction do
          teacher = ::Teacher.new(
            name: name, email: email, password: password, password_confirmation: password,
            jti: JWT.encode({ email: email }, Settings.jwt_hmac_secret, 'HS256')
          )
          teacher.build_profile(profile_attributes)
          teacher.subjects = Subject.where(name: subjects)
          teacher.branch_schools = BranchSchool.where(name: branch_schools)
          teacher.save!
        end
      end
    end
  end
end
