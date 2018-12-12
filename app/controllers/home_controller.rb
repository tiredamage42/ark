class HomeController < ApplicationController

    def index
        #if not signed in go to log in screen
        if !user_signed_in?
            redirect_to new_user_session_path
        end
        redirect_to posts_path

    end

end