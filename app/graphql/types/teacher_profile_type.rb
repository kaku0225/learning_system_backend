module Types
  class TeacherProfileType < Types::BaseObject
    field :gender, String, null: false
    field :cellphone, String, null: false
    field :school, String, null: false
    field :major, String, null: false
  end
end
