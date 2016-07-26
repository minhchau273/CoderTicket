class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to root_path
    else
      @error = params[:error].present?
      render layout: false
    end
  end

  def create
    @user = User.find_by_email(session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to login_path(error: true)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
