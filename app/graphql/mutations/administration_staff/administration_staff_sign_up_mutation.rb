module Mutations
  module AdministrationStaff
    class AdministrationStaffSignUpMutation < Mutations::BaseMutation
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

      def resolve(name:, email:, branch_schools:, **profile_attributes)
        password = generate_random_password

        begin
          create_administration_staff(name, email, password, branch_schools, profile_attributes)
          ContactMailer.temp_password(email, password).deliver_later
          { success: true, administration_staffs: ::AdministrationStaff.includes(:profile, :branch_schools) }
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

      def create_administration_staff(name, email, password, branch_schools, profile_attributes)
        ::AdministrationStaff.transaction do
          administration_staff = ::AdministrationStaff.new(
            name: name, email: email, password: password, password_confirmation: password,
            jti: JWT.encode({ email: email }, Settings.jwt_hmac_secret, 'HS256')
          )
          administration_staff.build_profile(profile_attributes)
          administration_staff.branch_schools = BranchSchool.where(name: branch_schools)
          administration_staff.save!
        end
      end
    end
  end
end
