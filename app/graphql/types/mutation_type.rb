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

    ## AdministrationStaff
    field :administration_staff_sign_up, mutation: ::Mutations::AdministrationStaff::AdministrationStaffSignUpMutation
    field :administration_staff_update, mutation: ::Mutations::AdministrationStaff::AdministrationStaffUpdateMutation

    ## Teacher
    field :teacher_sign_up, mutation: ::Mutations::Teacher::TeacherSignUpMutation
    field :teacher_update, mutation: ::Mutations::Teacher::TeacherUpdateMutation

    ## BranchSchool
    field :branch_school_create, mutation: ::Mutations::BranchSchool::BranchSchoolCreateMutation
    field :branch_school_update, mutation: ::Mutations::BranchSchool::BranchSchoolUpdateMutation
  end
end
