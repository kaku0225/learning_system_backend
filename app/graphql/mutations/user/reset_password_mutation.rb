module Mutations
  module User
    class ResetPasswordMutation < Mutations::BaseMutation
      argument :token, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      field :user, Types::UserType
      field :success, Boolean, null: false
      field :message, String

      def resolve(token:, password:, password_confirmation:)
        errors = check_token_and_find_user(token)
        if @user.present?
          reset_password(password, password_confirmation)
        else
          { success: false, message: errors }
        end
      end

      private

      def check_token_and_find_user(token)
        JWT.decode token, Settings.jwt_hmac_secret, true, { algorithm: 'HS256' }
        @user = ::User.find_by(reset_jti: token)
        I18n.t('messages.invalid_token') if @user.blank?
      rescue JWT::ExpiredSignature
        I18n.t('messages.please_resend_the_password_reset_email')
      rescue JWT::DecodeError
        I18n.t('messages.invalid_token')
      end

      def reset_password(password, password_confirmation)
        @user.assign_attributes(
          password: password,
          password_confirmation: password_confirmation,
          reset_jti: nil
        )

        if @user.save
          { success: true, user: @user }
        else
          { success: false, message: @user.errors.full_messages.join('、') }
        end
      end
    end
  end
end
