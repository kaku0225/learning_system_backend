module Types
  class MutationType < Types::BaseObject
    ## User
    field :login, mutation: ::Mutations::User::LoginMutation
    field :logout, mutation: ::Mutations::User::LogoutMutation
    field :send_reset_password_email, mutation: ::Mutations::User::SendResetPasswordEmailMutation
    field :reset_password, mutation: ::Mutations::User::ResetPasswordMutation

    ## Student
    field :student_sign_up, mutation: ::Mutations::Student::StudentSignUpMutation
    field :student_sign_up_by_class_adviser, mutation: ::Mutations::Student::StudentSignUpByClassAdviserMutation
    field :student_update_by_class_adviser, mutation: ::Mutations::Student::StudentUpdateByClassAdviserMutation
    field :switch_enabled, mutation: ::Mutations::Student::SwitchEnabledMutation

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

    ## Schedule
    field :schedule_create_or_destroy, mutation: ::Mutations::Schedule::ScheduleCreateOrDestroyMutation
    field :schedule_update, mutation: ::Mutations::Schedule::ScheduleUpdateMutation

    ## TodoList
    field :todo_list_create, mutation: ::Mutations::TodoList::TodoListCreateMutation
  end
end
