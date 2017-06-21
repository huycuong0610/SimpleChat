class UsersController < ApplicationController

before_action :require_login, only: [:index, :show, :sent, :show_friend, :all_user]
	def index
		#@users = User.all
		@messages = Message.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new user_params
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_path, notice: "Account created"
		else
			render "new"
		end
	end

    def create 
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Account created successful"
        else
            flash[:errors] = "Please check information"
            render "new"
        end
    end

	def user_params
		params.require(:user).permit(:name, :email, :password)
	end



end
