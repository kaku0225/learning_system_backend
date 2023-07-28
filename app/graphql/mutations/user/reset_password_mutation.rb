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
        check(token, password, password_confirmation)

        if @errors.present?
          { success: false, message: @errors }
        else
          begin
            decoded_token = JWT.decode token, Settings.jwt_hmac_secret, true, { algorithm: 'HS256' }
            user = ::User.find_by(email: decoded_token[0]['email'])
            user.update(password: password, reset_jti: nil)
            { success: true, user: user }
          rescue JWT::ExpiredSignature
            { success: false, message: 'Expired, please resend the password reset email' }
          end
        end
      end

      private

      def check(token, password, password_confirmation)
        @errors = []
        check_password_matches(password, password_confirmation)
        check_token_exists(token)
      end

      def check_password_matches(password, password_confirmation)
        @errors << 'Inconsistent password input' unless password.eql?(password_confirmation)
      end

      def check_token_exists(token)
        @errors << 'Invalid token' if ::User.where(reset_jti: token).blank?
      end
    end
  end
end
