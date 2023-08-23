module Types
  module Inputs
    class StudentProfileInputType < Types::BaseInputObject
      argument :birthday, String, required: true
      argument :cellphone, String, required: true
      argument :phone, String, required: true
      argument :school, String, required: true
      argument :main_grade, String, required: true
      argument :sub_grade, String, required: true
      argument :county, String, required: true
      argument :address, String, required: true
    end
  end
end
