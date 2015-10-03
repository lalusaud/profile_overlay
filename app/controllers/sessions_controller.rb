class SessionsController < ApplicationController

  def create
    # begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      session[:image_url] = @user.image_url
    # rescue
    #   flash[:warning] = "There was an error while trying to authenticate you..."
    # end
    redirect_to profile_path
  end

end
