module Mutations
  module User
    class SendResetPasswordEmailMutation < Mutations::BaseMutation
      argument :email, String, required: true

      field :user, Types::UserType
      field :success, Boolean, null: false
      field :message, String

      def resolve(email:)
        user = ::User.find_by(email: email)

        if user.present?
          ContactMailer.reset_password(user).deliver_later
          { user: user, success: true }
        else
          { success: false, message: I18n.t('messages.email_sending_failed') }
        end
      end
    end
  end
end
