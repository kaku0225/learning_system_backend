module Mutations
  module ClassAdviser
    class ClassAdviserSignUpMutation < Mutations::BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :cellphone, String, required: true
      argument :branch_schools, [String], required: true

      field :class_advisers, [Types::ClassAdviserType]
      field :success, Boolean, null: false
      field :message, String

      def resolve(name:, email:, branch_schools:, **profile_attributes)
        password = generate_random_password

        begin
          create_class_adviser(name, email, password, branch_schools, profile_attributes)
          ContactMailer.temp_password(email, password).deliver_later
          { success: true, class_advisers: ::ClassAdviser.includes(:profile) }
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

      def create_class_adviser(name, email, password, branch_schools, profile_attributes)
        ::ClassAdviser.transaction do
          class_adviser = ::ClassAdviser.new(
            name: name, email: email, password: password, password_confirmation: password,
            jti: JWT.encode({ email: email }, Settings.jwt_hmac_secret, 'HS256')
          )
          class_adviser.build_profile(profile_attributes)
          class_adviser.branch_schools = BranchSchool.where(name: branch_schools)
          class_adviser.save!
        end
      end
    end
  end
end
