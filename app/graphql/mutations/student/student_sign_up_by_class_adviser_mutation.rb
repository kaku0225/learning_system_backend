module Mutations
  module Student
    class StudentSignUpByClassAdviserMutation < Mutations::BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :profile, Types::Inputs::StudentProfileInputType, required: true
      argument :branch_schools, [String], required: true

      field :students, [Types::StudentType]
      field :success, Boolean, null: false
      field :message, String

      def resolve(params)
        password = generate_random_password

        ::Student.transaction do
          student = build_student(params, password)
          student.save!
          ContactMailer.temp_password(params[:email], password).deliver_later
          { success: true, students: ::Student.includes(:profile, :branch_schools).order(id: :desc) }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, message: e.record.errors.full_messages.join('、 ') }
        end
      end

      private

      def build_student(params, password)
        student = ::Student.new(name: params[:name], email: params[:email], password: password, enabled: true)
        student.jti = generate_jti(params[:email])
        student.build_profile(params[:profile].to_h)
        student.branch_schools = find_branch_schools(params[:branch_schools])
        student
      end

      def generate_jti(email)
        JWT.encode({ email: email }, Settings.jwt_hmac_secret, 'HS256')
      end

      def find_branch_schools(names)
        ::BranchSchool.where(name: names)
      end

      def generate_random_password
        [
          [*'A'..'Z'].sample,
          [*'a'..'z'].sample,
          [*'0'..'9'].sample,
          *[*('a'..'z'), *('0'..'9'), *('A'..'Z')].sample(5)
        ].shuffle.join
      end
    end
  end
end
