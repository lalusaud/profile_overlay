require 'open-uri'
class OverlayController < ApplicationController
  after_filter :allow_iframe_requests
  before_filter :require_login, except: [:index, :privacy]
  before_filter :fetch_image, only: [:publish, :download]

  def index
    if current_user
      redirect_to auth_provider_url
    end
  end

  def profile
    source = Overlay.get_source_image current_user
    @overlay_images = Overlay.images
    @overlay_images.each do |overlay|
      Overlay.create_image source, overlay, current_user
    end
  end

  def publish
    facebook = Koala::Facebook::API.new(current_user.token)
    img = facebook.put_picture(@file_path, {}, "me")
    url = "https://www.facebook.com/photo.php?fbid=#{img['id']}&makeprofile=1"

    redirect_to url
  end

  def privacy
  end

  def download
    data = open(@file_path)
    send_file data, filename: "profile_pic.jpg", type: "image/jpeg", disposition: 'attachment'
  end

  def allow_iframe_requests
    response.headers.delete 'X-Frame-Options'
  end

  private
    def fetch_image
      image = params.fetch(:image) if params[:image]
      url = 'https://s3.amazonaws.com/profile-overlay-assets'
      @file_path = "#{url}/#{current_user.uid}_#{image}.png"
    end

    def require_login
      redirect_to root_path unless current_user
    end
end
