module Types
  class ScheduleType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :start, GraphQL::Types::ISO8601DateTime, null: false
    field :start_str, GraphQL::Types::ISO8601Date, null: false
    field :end, GraphQL::Types::ISO8601DateTime, null: false
    field :all_day, Boolean, null: true
    field :teacher, Types::TeacherType, null: true

    def start_str
      object.start.to_date
    end
  end
end
