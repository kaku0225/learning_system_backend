module Types
  class MutationType < Types::BaseObject
    field :login, mutation: ::Mutations::User::LoginMutation
    field :sign_up, mutation: ::Mutations::Student::SignUpMutation
    field :send_reset_password_email, mutation: ::Mutations::User::SendResetPasswordEmailMutation
    field :reset_password, mutation: ::Mutations::Student::ResetPasswordMutation
    field :logout, mutation: ::Mutations::Student::LogoutMutation
    field :create, mutation: ::Mutations::TodoList::CreateMutation
  end
end
