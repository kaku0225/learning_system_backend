module Mutations
  module User
    class LogoutMutation < Mutations::BaseMutation
      argument :token, String, required: true

      field :expired_time, GraphQL::Types::ISO8601DateTime

      def resolve(token:)
        expired_time = Time.current
        decoded_token = JWT.decode token, Settings.jwt_hmac_secret, true, { algorithm: 'HS256' }
        user = ::User.find_by(email: decoded_token[0]['email'])
        user.update(jti: JWT.encode({ expired: expired_time, email: user.email }, Settings.jwt_hmac_secret, 'HS256'))
        { expired_time: expired_time }
      end
    end
  end
end
