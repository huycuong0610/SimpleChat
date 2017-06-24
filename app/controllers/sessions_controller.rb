class SessionsController < ApplicationController
  before_action :skip_login, only: [:new, :create]
  before_action :require_login, only: [:destroy]

  def new
  end

  def create
    if authenticate
      store_user_id(@user.id)
      flash[:notice] = 'Login successfully'
      redirect_to restore_path
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def callback
    if (user = FacebookAuthenticateService.new(env['omniauth.auth']).authenticate)
      session[:user_id] = user.id
      flash[:notice] = 'Login successfully'
      redirect_to users_path
    else
      flash.now[:alert] = 'Can not login with facebook'
      render :new
    end
  end

  def destroy
    clear_user_id
    flash[:notice] = 'Logout successfully'
    redirect_to new_sessions_path
  end

  private
  def authenticate
    @user = User.find_by(email: params[:email])
    @user && @user.authenticate(params[:password])
  end
end