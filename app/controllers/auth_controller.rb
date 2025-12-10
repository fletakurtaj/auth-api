class AuthController < ApplicationController

  def signup
    user = User.new(user_params)
    if user.save
      render json: { message: "Account created successfully", user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { token: token, user: user }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def me
    header = request.headers["Authorization"]
    return render json: { error: "Missing Authorization header" }, status: :unauthorized unless header&.starts_with?("Bearer ")

    token = header.split.last

    begin
      decoded = JWT.decode(token, ENV["SECRET_KEY_BASE"])
      user = User.find(decoded[0]["user_id"])
      render json: { user: user }, status: :ok
    rescue JWT::DecodeError
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def encode_token(payload)
    JWT.encode(payload, ENV["SECRET_KEY_BASE"])
  end
end
