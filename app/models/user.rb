class User < ApplicationRecord
  include BCrypt

  attr_accessor :password_confirmation

  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  # (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  has_secure_password

  has_many :todo_lists
  has_many :assigns, class_name: 'TodoList', foreign_key: :assign_id

  validates :email, :name, :cellphone, :school, presence: true
  validates :email, format: { with: /\A(.+)@(.+)\z/, message: 'Email invalid' }, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 254 }
  validates :password, format: { with: PASSWORD_FORMAT, message: I18n.t('errors.messages.password_invalid') }
end
