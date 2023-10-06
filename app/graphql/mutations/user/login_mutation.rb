module Mutations
  module User
    class LoginMutation < Mutations::BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType
      field :success, Boolean, null: false
      field :expired_time, GraphQL::Types::ISO8601DateTime
      field :message, String
      field :path, String

      def resolve(email:, password:)
        expired_time = Time.current + 6.months
        user = ::User.authenticate_by(email: email, password: password)
        if user.present?
          user.update_columns(jti: JWT.encode({ expired: expired_time, email: email }, Settings.jwt_hmac_secret, 'HS256'))
          { user: user, success: true, expired_time: expired_time, path: Settings.send(user.type).root }
        else
          { success: false, message: I18n.t('messages.invalid_email_or_password') }
        end
        # raise GraphQL::ExecutionError.new('Invalid email or password') unless user&.authenticate(password)

        # user.update(jti: JWT.encode({ expired: expired_time, email: email }, Settings.jwt_hmac_secret, 'HS256'))
        # { user: user }
      end
    end
  end
end
