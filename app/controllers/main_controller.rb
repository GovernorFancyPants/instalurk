require 'instagram'

class MainController < ApplicationController
    def index
        @client = Instagram.client(:access_token => session[:access_token])
        if(!params[:q])
            @location = Instagram.media_search("59.3325800","18.0649000", :distance=>5000)
        else
            @location = Instagram.location_recent_media(514276, :max_id => params[:q])
        end

        # p @location
        # p Location.geo_scope(:origin => my_store)

        respond_to do |format|
          format.html # show.html.erb
          format.json { render :json => @location }
        end
    end
    def get_location_ids
        @location = Instagram.media_search("59.3325800","18.0649000", :distance=>5000)
    end
end
