class SessionsController < ApplicationController
  layout "authentication"

  def new
    if current_user
      redirect_to root_path
    else
      @sign_in = SignIn.new
    end
  end

  def create
    if (@sign_in = SignIn.new(sign_in_params)).valid?
      session[:user_id] = @sign_in.user_id
      redirect_back_or_default
    else
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(:email, :password)
  end
end
