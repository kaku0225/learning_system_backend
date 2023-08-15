module Mutations
  module Student
    class LoginMutation < Mutations::BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::StudentType
      field :success, Boolean, null: false
      field :expired_time, GraphQL::Types::ISO8601DateTime
      field :message, String

      def resolve(email:, password:)
        expired_time = Time.current + 6.months
        user = ::User.find_by(email: email)
        if user&.authenticate(password)
          user.update_columns(jti: JWT.encode({ expired: expired_time, email: email }, Settings.jwt_hmac_secret, 'HS256'))
          { user: user, success: true, expired_time: expired_time }
        else
          { success: false, message: 'Invalid email or password' }
        end
        # raise GraphQL::ExecutionError.new('Invalid email or password') unless user&.authenticate(password)

        # user.update(jti: JWT.encode({ expired: expired_time, email: email }, Settings.jwt_hmac_secret, 'HS256'))
        # { user: user }
      end
    end
  end
end
