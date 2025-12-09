class ApplicationController < ActionController::API
  before_action :authorize_request

  def authorize_request
    header = request.headers["Authorization"]

    if header.present? && header.starts_with?("Bearer ")
      token = header.split.last
      begin
        decoded = JWT.decode(token, Rails.application.credentials.secret_key_base)
        @current_user = User.find(decoded[0]["user_id"])
      rescue JWT::DecodeError
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end