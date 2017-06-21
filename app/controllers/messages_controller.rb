class MessagesController < ApplicationController
    before_action :require_login, only: [:new,:create]
    def new
        @user = current_user
        @users = current_user.friends
        @message = Message.new
    end

    def create
    end
end
