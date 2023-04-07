class ApplicationController < ActionController::Base
  skip_forgery_protection  

  def jwt_authenticate
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      begin
        payload = JWT.decode(token, Rails.application.secret_key_base).first
        @current_user = User.find(payload['user_id'])
      rescue JWT::DecodeError
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { error: 'Token missing' }, status: :unauthorized and return
    end
  end
end
