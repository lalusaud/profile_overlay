class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def current_user
      @current_user = {
        id: session[:user_id], name: session[:user_name],
        image_url: session[:image_url]
      }
    end

    helper_method :current_user
end
