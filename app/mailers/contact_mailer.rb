class ContactMailer < ApplicationMailer
  def reset_password(user)
    @user = user
    @user.update_columns(reset_jti: build_reset_token(@user.email))
    mail to: @user.email, subject: '密碼重置'
  end

  def temp_password(email, password)
    @password = password
    mail to: email, subject: '學習系統帳號'
  end

  private

  def build_reset_token(email)
    exp = Time.current.to_i + 300
    exp_payload = { email: email, exp: exp }
    JWT.encode exp_payload, Settings.jwt_hmac_secret, 'HS256'
  end
end
