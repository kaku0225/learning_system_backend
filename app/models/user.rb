class User < ApplicationRecord
  include BCrypt

  attr_accessor :password_confirmation
  attr_accessor :create_or_update_password

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

  with_options if: :create_or_update_password do
    validates :password, format: { with: PASSWORD_FORMAT, message: I18n.t('errors.messages.password_invalid') }
  end

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end
end
