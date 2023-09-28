module Mutations
  module Schedule
    class ScheduleCreateOrDestroyMutation < Mutations::BaseMutation
      argument :teacher_id, String, required: true
      argument :title, String, required: true
      argument :start, GraphQL::Types::ISO8601DateTime, required: true
      argument :end, GraphQL::Types::ISO8601DateTime, required: true
      argument :all_day, Boolean, required: true

      field :schedules, [Types::ScheduleType]
      field :success, Boolean, null: false
      field :message, String

      def resolve(**arguments)
        schedule = ::Schedule.find_or_initialize_by(arguments)
        schedule.persisted? ? schedule.destroy : schedule.save!
        { success: true, schedules: ::Schedule.includes(:teacher) }
      rescue ActiveRecord::RecordInvalid => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      end
    end
  end
end
