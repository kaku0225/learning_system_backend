module Types
  module Inputs
    class UserInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
    end
  end
end
