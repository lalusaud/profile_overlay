class SessionsController < ApplicationController

  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user['id']
      session[:user_name] = @user['name']
      session[:image_url] = @user['picture']['data']['url']

      session[:access_token] = request.env['omniauth.auth']['credentials']['token']
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to profile_path
  end

end
