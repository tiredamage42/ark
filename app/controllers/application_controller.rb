class ApplicationController < ActionController::Base


    before_action :init_messaging


    private


    def init_messaging

        session[:conversations] ||= []
    
        #for chat list
        @users = User.all.where.not(id: current_user)
        @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])

    end


end
