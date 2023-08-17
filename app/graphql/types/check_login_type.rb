module Types
  class CheckLoginType < Types::BaseObject
    field :success, Boolean, null: false
    field :path, String
  end
end
