module Types
  class MutationType < Types::BaseObject
    field :login, mutation: ::Mutations::User::LoginMutation
    field :student_sign_up, mutation: ::Mutations::Student::StudentSignUpMutation
    field :send_reset_password_email, mutation: ::Mutations::User::SendResetPasswordEmailMutation
    field :reset_password, mutation: ::Mutations::User::ResetPasswordMutation
    field :logout, mutation: ::Mutations::User::LogoutMutation
    field :create, mutation: ::Mutations::TodoList::CreateMutation
    field :class_adviser_sign_up, mutation: ::Mutations::ClassAdviser::ClassAdviserSignUpMutation
  end
end
