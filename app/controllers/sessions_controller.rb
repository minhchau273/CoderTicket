class SessionsController < ApplicationController
  layout 'authentication'

  def new
    build_sign_in
  end

  def create
    build_sign_in
    if @sign_in.valid?
      session[:user_id] = @sign_in.user_id
      redirect_to root_path, notice: "Signed in successfullly."
    else
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def build_sign_in
    @sign_in = SignIn.new sign_in_params
  end

  def sign_in_params
    params.require(:sign_in).permit(:email, :password) if params[:sign_in]
  end
end
