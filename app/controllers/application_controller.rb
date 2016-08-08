class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    if session_id = session[:user_id]
      @current_user ||= User.find(session_id)
    end
  end

  def store_location_and_require_login
    session[:previous_url] = request.url
    redirect_to login_path
  end

  def redirect_back_or_default
    redirect_to(session[:previous_url] || root_path)
    session[:previous_url] = nil
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    model_name = exception.message.match(/Couldn't find (\w+)/)[1] || "resource"
    redirect_to root_path, alert: "This #{model_name.downcase} is not available."
  end
end
