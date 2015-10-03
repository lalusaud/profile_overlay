require 'rmagick'

class OverlayController < ApplicationController
  skip_before_filter :verify_authenticity_token
  after_filter :allow_iframe_requests

  def index
    redirect_to auth_provider_url
  end

  def profile
    overlay
  end

  def overlay
    # source = Magick::Image.read("app/assets/images/minions.png").first
    source = Magick::ImageList.new
    image_url = URI.parse(current_user[:image_url])
    image_url.scheme = 'https'
    urlimage = open(image_url)
    source.from_blob(urlimage.read).first

    source = source.resize_to_fill(200, 200)
    overlay = Magick::Image.read("app/assets/images/overlay_flag.png").first
    overlay.opacity = (Magick::TransparentOpacity-Magick::OpaqueOpacity) * 0.75
    source.composite!(overlay, 0, 0, Magick::OverCompositeOp)
    filename = "#{current_user[:id]}.png"
    source.write("app/assets/images/#{filename}")
  end

  def allow_iframe_requests
    response.headers.delete 'X-Frame-Options'
  end
end
