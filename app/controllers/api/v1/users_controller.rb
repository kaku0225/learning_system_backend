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

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
