class ApplicationController < ActionController::API
  include ActionController::Cookies

  # Disable CSRF because this is an API
  protect_from_forgery with: :null_session
end
