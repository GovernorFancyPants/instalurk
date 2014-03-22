require 'instagram'

class Api::ApiController < ApplicationController
    def get_location_ids
        @client = Instagram.client(:access_token => session[:access_token])
        @location = Instagram.media_popular
        # @location = Instagram.media_search(params["lat"], params["long"], :distance=>5000)
        respond_to do |format|
          format.json { render :json => @location }
        end
    end
end

