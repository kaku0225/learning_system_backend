module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :check_authentication, Types::CheckLoginType, null: false do
      argument :token, String, required: true
      argument :path, String, required: true
    end

    def check_authentication(token:, path:)
      user = User.find_by(jti: token)

      if user.blank? || token.blank?
        handle_blank_user_or_token(path)
      else
        type = user.type
        handle_authenticated_user(user, type, path)
      end
    end

    field :exam_countdown, Types::ExamCountdownType, null: false

    def exam_countdown
      s_exam = '2024-09-18'
      c_exam = '2024-12-05'

      { sectional_exam: (s_exam.to_time.to_i - Time.current.to_i) * 1000, comprehensive_assessment_program: (c_exam.to_time.to_i - Time.current.to_i) * 1000 }
    end

    field :todo_list_by_status, Types::TodoListByStatus, null: false do
      argument :token, String, required: true
    end

    def todo_list_by_status(token:)
      decoded_token = JWT.decode token, Settings.jwt_hmac_secret, true, { algorithm: 'HS256' }
      student = ::Student.find_by(email: decoded_token[0]['email'])
      if student.present?
        { pending_todo_lists: student.todo_lists.where(status: 'pending'), done_todo_lists: student.todo_lists.where(status: 'done') }
      else
        { pending_todo_lists: [], done_todo_lists: [] }
      end
    end

    field :branch_schools, [Types::BranchSchoolType], null: false

    def branch_schools
      BranchSchool.includes(:users)
    end

    field :class_advisers, [Types::ClassAdviserType], null: false

    def class_advisers
      ClassAdviser.includes(:profile, :branch_schools)
    end

    field :teachers, [Types::TeacherType], null: false

    def teachers
      Teacher.includes(:profile, :branch_schools, :subjects, :schedules)
    end

    field :administration_staffs, [Types::AdministrationStaffType], null: false

    def administration_staffs
      AdministrationStaff.includes(:profile, :branch_schools)
    end

    field :students, [Types::StudentType], null: false

    def students
      Student.includes(:profile, :branch_schools).order(id: :desc)
    end

    field :schedules, [Types::ScheduleType], null: false

    def schedules
      Schedule.includes(:teacher)
    end

    field :schedule_duplicate, Boolean, null: false do
      argument :title, String, required: true
      argument :start, GraphQL::Types::ISO8601DateTime, required: true
      argument :end_time, GraphQL::Types::ISO8601DateTime, required: true
      argument :all_day, Boolean, required: true
    end

    def schedule_duplicate(title:, start:, end_time:, all_day:)
      Schedule.find_by(title: title, start: start, end: end_time, all_day: all_day).present? ? true : false
    end

    private

    def expired_token?(token)
      decoded_token = JWT.decode token, Settings.jwt_hmac_secret, true, { algorithm: 'HS256' }
      decoded_token[0]['expired'] < Time.current
    end

    def handle_blank_user_or_token(path)
      if path == '/login'
        { success: true }
      else
        { success: false, path: '/login' }
      end
    end

    def handle_authenticated_user(user, type, path)
      if allowed_path?(type, path)
        { success: true }
      else
        { success: false, path: format(Settings.send(type).root, id: user.id) }
      end
    end

    def allowed_path?(type, path)
      Settings.send(type).routes.include?(path)
    end
  end
end
