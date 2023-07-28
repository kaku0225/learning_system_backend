module Types
  class MutationType < Types::BaseObject
    field :login, mutation: ::Mutations::User::LoginMutation
    field :sign_up, mutation: ::Mutations::User::SignUpMutation
    field :send_reset_password_email, mutation: ::Mutations::User::SendResetPasswordEmailMutation
    field :reset_password, mutation: ::Mutations::User::ResetPasswordMutation
  end
end
