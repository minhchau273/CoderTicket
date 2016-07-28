class UsersController < ApplicationController
  layout "authentication"

  def new
    @user = User.new
  end

  def create
    if (@user = User.new(user_params)).save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
