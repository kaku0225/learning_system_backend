module Mutations
  module User
    class ResetPasswordMutation < Mutations::BaseMutation
      argument :token, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      field :user, Types::StudentType
      field :success, Boolean, null: false
      field :message, String

      def resolve(token:, password:, password_confirmation:)
        user = ::User.find_by_token_for(:password_reset, token)

        if user.present?
          reset_password(user, password, password_confirmation)
        else
          { success: false, message: I18n.t('messages.please_resend_the_password_reset_email') }
        end
      end

      private

      def reset_password(user, password, password_confirmation)
        user.assign_attributes(
          password: password,
          password_confirmation: password_confirmation,
          reset_jti: nil
        )

        user.create_or_update_password = true

        if user.save
          { success: true, user: user }
        else
          { success: false, message: user.errors.full_messages.join('、') }
        end
      end
    end
  end
end
