require 'instagram'

class MainController < ApplicationController
    def index
        if !client_is_autorized()
            redirect_to "/" 
        end
        @client = Instagram.client(:access_token => session[:access_token])
    end
end
