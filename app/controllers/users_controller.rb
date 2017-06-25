class UsersController < ApplicationController

before_action :require_login, only: [:index, :show, :sent, :show_friend, :all_user]
	def index
		#@users = User.all
		@messages = current_user.lastest_received_messages(10)
	end


	def new
		@user = User.new
	end

	def edit
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

	def block
		@friend_ship = Friendship.find_by(friend_id: params[:friend_id], user_id: current_user.id)
		@friend_ship.update_attributes(block: 1)
		@friend = User.find(params[:friend_id]) 

		flash[:notice] = "Block friend *#{@friend.name}* . You never receive any message from this user."
		redirect_to friends_path
	end


	def unblock
		@friend_ship = Friendship.find_by(friend_id: params[:friend_id], user_id: current_user.id)
		@friend_ship.update_attributes(block: nil)
		@friend = User.find(params[:friend_id]) 

		flash[:notice] = "Unblock Block friend *#{@friend.name}*. You can receive message from this user."
		redirect_to friends_path
	end


end
