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
            redirect_to root_path, notice: "Account created successful"
        else
            flash[:errors] = "Please check information"
            render "new"
        end
    end

	def all_user
		@users = User.all.where.not(id: current_user.id )
	end

	def user_params
		params.require(:user).permit(:name, :email, :password)
	end

	def show
		@messages = current_user.lastest_received_messages(100)
	end

	def sent
		@messages = current_user.sent_messages
	end

	def show_friend
		@friend_list = current_user.friends
	end

	def message_new
		@friend_list = current_user.friends
		@message = Message.new
	end


end
