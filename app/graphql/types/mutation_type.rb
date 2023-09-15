module Types
  class MutationType < Types::BaseObject
    ## User
    field :login, mutation: ::Mutations::User::LoginMutation
    field :logout, mutation: ::Mutations::User::LogoutMutation
    field :send_reset_password_email, mutation: ::Mutations::User::SendResetPasswordEmailMutation
    field :reset_password, mutation: ::Mutations::User::ResetPasswordMutation

    ## Student
    field :student_sign_up, mutation: ::Mutations::Student::StudentSignUpMutation
    field :create_todo_list, mutation: ::Mutations::Student::CreateTodoListMutation

    ## ClassAdviser
    field :class_adviser_sign_up, mutation: ::Mutations::ClassAdviser::ClassAdviserSignUpMutation
    field :class_adviser_update, mutation: ::Mutations::ClassAdviser::ClassAdviserUpdateMutation

    ## Admin
    field :create_branch_school, mutation: ::Mutations::Admin::CreateBranchSchoolMutation
  end
end
