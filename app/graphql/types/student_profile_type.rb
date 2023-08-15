module Types
  class StudentProfileType < Types::BaseObject
    field :birthday, String, null: false
    field :cellphone, String, null: false
    field :phone, String, null: false
    field :school, String, null: false
    field :main_grade, String, null: false
    field :sub_grade, String, null: false
    field :county, String, null: false
    field :address, String, null: false
    field :branch_school, String, null: false
  end
end
