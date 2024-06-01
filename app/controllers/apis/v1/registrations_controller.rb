class Apis::V1::RegistrationsController < ApplicationController
  #skip_before_action :jwt_authenticate, only: [:create]

  def create
    user = User.new(registration_params)
    if user.save
      token = JWT.encode({ user_id: user.id }, Rails.application.secret_key_base)
      username = registration_params[:email].split("@").first
      render json: { token: token, username: username, admin: user.admin, email: user.email}
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
