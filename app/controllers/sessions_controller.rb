class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to '/'
    else
      @error = params[:error].present?
      render layout: false
    end
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to login_path(error: true)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
