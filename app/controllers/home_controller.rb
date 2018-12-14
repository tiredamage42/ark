class HomeController < ApplicationController

    #home should show confirmed artist profiles
    # featured, new, popular, random?

    def index
        #if not signed in go to log in screen
        if !user_signed_in?
            redirect_to new_user_session_path

            
        else
            redirect_to posts_path
        end

        
        

    end

end