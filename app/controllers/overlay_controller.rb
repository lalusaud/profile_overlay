class OverlayController < ApplicationController
  skip_before_filter :verify_authenticity_token
  after_filter :allow_iframe_requests

  def index
    redirect_to auth_provider_url
  end

  def profile
    @overlay_images = %w(overlay_dashain.png overlay_flag.png overlay_dharahara.png overlay_merodesh.png)
    source = Overlay.get_source_image current_user
    @overlay_images.each do |overlay|
      Overlay.create_image source, overlay, current_user
    end
  end

  def publish
    overlay_image = params.fetch(:image)
    file_path = "app/assets/images/#{current_user[:id]}_#{overlay_image}.png"
    facebook = Koala::Facebook::API.new(session[:access_token])
    result = facebook.put_picture(file_path, {:message => "My upload message"}, "me")
    url = "http://www.facebook.com/photo.php?fbid=#{result['id']}&makeprofile=1"

    redirect_to url
  end

  def allow_iframe_requests
    response.headers.delete 'X-Frame-Options'
  end
end
