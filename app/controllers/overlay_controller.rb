class OverlayController < ApplicationController
  skip_before_filter :verify_authenticity_token
  after_filter :allow_iframe_requests
  before_filter :fetch_image, only: [:publish, :download]

  def index
    redirect_to auth_provider_url
  end

  def profile
    source = Overlay.get_source_image current_user
    @overlay_images = %w(dashain.png npflag.png dharahara.png merodesh.png)
    @overlay_images.each do |overlay|
      Overlay.create_image source, overlay, current_user
    end
  end

  def publish
    facebook = Koala::Facebook::API.new(session[:access_token])
    img = facebook.put_picture(@file_path, {}, "me")
    url = "https://www.facebook.com/photo.php?fbid=#{img['id']}&makeprofile=1"

    redirect_to url
  end

  def download
    send_file @file_path, :type => 'image/jpeg', :disposition => 'attachment'
  end

  def allow_iframe_requests
    response.headers.delete 'X-Frame-Options'
  end

  private
    def fetch_image
      image = params.fetch(:image)
      @file_path = "app/assets/images/#{current_user[:id]}_#{image}.png"
    end
end
