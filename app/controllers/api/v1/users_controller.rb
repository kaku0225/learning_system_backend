module Api
  module V1
    class UsersController < ApplicationController
      def sign_up
        if User.find_by(email: params[:user][:email]).present?
          render json: { success: false, code: 406 }
        else
          user = User.new(user_params.merge(jti: JWT.encode({ email: params[:user][:email] }, Settings.jwt_hmac_secret, 'HS256')))
          user.save!
          render json: { success: true, code: 200, user: user }
        end
      end

      def login
        expired_time = Time.current + 6.hours
        user = User.find_by(email: params[:user][:email])&.authenticate(params[:user][:password])
        if user.present?
          user.update(jti: JWT.encode({ expired: expired_time, email: params[:user][:email] }, Settings.jwt_hmac_secret, 'HS256'))
          render json: { success: true, code: 200, token: user.jti, expired: expired_time }
        else
          render json: { success: false, code: 401 }
        end
      end

      def send_reset_password_email
        user = User.find_by(email: params[:email])
        if user.present?
          ContactMailer.reset_password(user).deliver_later
          render json: { success: true, code: 200 }
        else
          render json: { success: false, code: 401 }
        end
      end

      def reset_password
        render json: { success: true, code: 200 }
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
