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

  has_many :branch_school_relations
  has_many :branch_schools, through: :branch_school_relations

  validates :email, :name, presence: true
  validates :email, format: { with: /\A(.+)@(.+)\z/, message: I18n.t('errors.messages.email_invalid') }, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 254 }
  validates :password, format: { with: PASSWORD_FORMAT, message: I18n.t('errors.messages.password_invalid') }
end
