class ContactMailer < ApplicationMailer
  def reset_password(user)
    @token = user.generate_token_for(:password_reset)
    mail to: user.email, subject: '密碼重置'
  end

  def temp_password(email, password)
    @password = password
    mail to: email, subject: '學習系統帳號'
  end
end
