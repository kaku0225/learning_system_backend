module Mutations
  module Schedule
    class ScheduleUpdateMutation < Mutations::BaseMutation
      argument :id, String, required: true
      argument :start, GraphQL::Types::ISO8601DateTime, required: true
      argument :end, GraphQL::Types::ISO8601DateTime, required: true

      field :schedules, [Types::ScheduleType]
      field :success, Boolean, null: false
      field :message, String

      def resolve(id:, **arguments)
        schedule = ::Schedule.find(id)
        ::Schedule.transaction do
          schedule.assign_attributes(arguments)
          schedule.save!
        end
        { success: true, schedules: ::Schedule.includes(:teacher) }
      rescue ActiveRecord::RecordNotFound => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      rescue ActiveRecord::RecordInvalid => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      end
    end
  end
end
