class SessionsController < ApplicationController
  def new
  end

  def create
  	if @user = User.find_by(email: params[:email])
  		if @user.authenticate(params[:password])
  			session[:user_id] = @user.id
  			redirect_to show_path, flash: {success: "Welcome back"}
  		else
  			redirect_to new_session_path, notice: "password is wrong"
  		end
  	else
  		redirect_to new_session_path, notice: "Email not found"
  	end
  end

  def callback
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to new_session_path, notice: "Logged out"
  end

	private
  def authenticate
    @user = User.find_by(email: params[:email])
    @user && @user.authenticate(params[:password])
  end
end
