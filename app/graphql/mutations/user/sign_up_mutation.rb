module Mutations
  module User
    class SignUpMutation < Mutations::BaseMutation
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

      field :user, Types::UserType
      field :success, Boolean, null: false
      field :message, String

      def resolve(**args)
        @user = ::User.new(args.merge(jti: JWT.encode({ email: args[:email] }, Settings.jwt_hmac_secret, 'HS256')))
        if @user.save
          { success: true, user: @user }
        else
          { success: false, message: @user.errors.full_messages.join('、 ') }
        end
      end
    end
  end
end
