require 'instagram'

class Api::ApiController < ApplicationController
    def get_location_ids
        @comsumer_key = "Jlz7F42F9ttwe7UfzTRo7g"
        @consumer_secret = "VMk5tKiW0CWaGDYly0ADFUKIU4B3v1ikuv4akbg4"
        @access_token = "767251675-ENknRgoDpTwbvqtR5pYRmlbiqJVkZ2MD15bX6Ygj"
        @access_token_secret = "KoFjMcDKSYXgDsLFzjoRJh5PyaM0ZicCIpRbBs8R8"

        # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
        def prepare_access_token(oauth_token, oauth_token_secret)
            consumer = OAuth::Consumer.new(@comsumer_key, @consumer_secret,
                { :site => "http://api.twitter.com",
                    :scheme => :query_string
                    })
          # now create the access token object from passed values
          token_hash = { :oauth_token => oauth_token,
            :oauth_token_secret => oauth_token_secret
          }
          access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
          return access_token
        end

        # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
        access_token = prepare_access_token(@access_token, @access_token_secret)
        # use the access token as an agent to get the home timeline
        response = access_token.request(:get, "https://api.twitter.com/1.1/search/tweets.json?geocode=#{params["lat"]}%2C#{params["long"]}%2C1km")
        p "https://api.twitter.com/1.1/search/tweets.json?geocode=#{params["lat"]}%2C#{params["long"]}%2C1km"
        @project = JSON.parse(response.body)
        ary = Array.new

        for x in @project['statuses'] do
            if x['entities']['media'] != nil
                x['provider'] = "twitter"
                ary.push(x)
            end
        end

        # respond_to do |format|
        #   format.html # show.html.erb
        #   format.json { render json: ary.to_json }
        # end

        @client = Instagram.client(:access_token => session[:access_token])
        @location = Instagram.media_popular
        @location = Instagram.media_search(params["lat"], params["long"], :distance=>5000)

        @location.each { |d|  d.provider = 'instagram' }

        @location.concat(ary)


        respond_to do |format|
          format.json { render :json => @location.to_json }
        end
    end

end

