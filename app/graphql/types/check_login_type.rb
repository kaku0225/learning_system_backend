module Types
  class CheckLoginType < Types::BaseObject
    field :success, Boolean, null: false
    field :role, String
  end
end
