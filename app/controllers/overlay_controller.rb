class OverlayController < ApplicationController

  def index
    overlay
  end

  def overlay
    source = Magick::Image.read("app/assets/images/minions.png").first
    source = source.resize_to_fill(200, 200)
    overlay = Magick::Image.read("app/assets/images/overlay_flag.png").first
    overlay.opacity = (Magick::TransparentOpacity-Magick::OpaqueOpacity) * 0.70
    source.composite!(overlay, 0, 0, Magick::OverCompositeOp)
    source.write("app/assets/images/profile_overlay.png")
  end
end
