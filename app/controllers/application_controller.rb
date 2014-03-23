class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :client_is_autorized

  def client_is_autorized
    @client = Instagram.client(:access_token => session[:access_token])
    if @client.access_token
        return true 
    else
       return false
    end
  end
end
