module Mutations
  module User
    class SignUpMutation < Mutations::BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType
      field :success, Boolean, null: false
      field :message, String

      def resolve(name:, email:, password:)
        if ::User.find_by(email: email).present?
          { success: false, message: 'Register failed' }
        else
          user = ::User.new(name: name, email: email, password: password, jti: JWT.encode({ email: email }, Settings.jwt_hmac_secret, 'HS256'))
          user.save!
          { success: true, user: user }
        end
      end
    end
  end
end
