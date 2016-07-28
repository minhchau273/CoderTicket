class UsersController < ApplicationController
  layout 'authentication'

  def new
    build_user
  end

  def create
    build_user
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Signed up successfully. Welcome!"
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation) if params[:user]
  end

  def build_user
    @user = User.new(user_params)
  end
end
