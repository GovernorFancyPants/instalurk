class SplashController < ApplicationController
    def index
        @client = Instagram.client(:access_token => session[:access_token])
        if @client.access_token
            redirect_to "/main"  
        end
    end
end
