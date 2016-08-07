class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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
    redirect_to root_url, alert: exception.message
  end
end
