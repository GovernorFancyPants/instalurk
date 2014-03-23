class SplashController < ApplicationController
    def index
        if client_is_autorized()
            redirect_to "/main" 
        end
        
        if params[:logout] == "1"
            @logout = true 
        else
            @logout = false
        end
    end
end
