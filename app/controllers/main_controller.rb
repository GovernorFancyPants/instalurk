require 'instagram'

class MainController < ApplicationController
    def index
        @client = Instagram.client(:access_token => session[:access_token])
        @location =  Instagram.location_recent_media(514276)

        respond_to do |format|
          format.html # show.html.erb
          format.json { render :json => @location }
        end
    end
end
