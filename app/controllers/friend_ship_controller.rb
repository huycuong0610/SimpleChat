class FriendShipController < ApplicationController
    def index
    end

    def create
        @friend_id = params[:friend_id]
        @friend_ship = current_user.friendships.build(:friend_id => @friend_id)
        if @friend_ship.save
            flash[:notice] = "Added friend"
            redirect_to friends_path
        else
            flash[:notice] = "Unable to add friend. Please contact administrator"
            redirect_to root_path
        end
    end

    def destroy
        @friend_ship = current_user.friendships.find(params[:id])
        @friend = User.find(@friend_ship.friend_id) 
        if @friend_ship.destroy
            flash[:notice] = "Removed #{@friend.name} from your friend list already"
            redirect_to friends_path
        else
            flash[:notice] = "Unable to remove friendship. Please contact administrator"
            redirect_to root_path
        end
    end


end
