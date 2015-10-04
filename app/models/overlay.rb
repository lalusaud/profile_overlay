class Overlay
  def self.create_image source, overlay_image, user
    source = source.resize_to_fill(400, 400)

    overlay = Magick::Image.read("app/assets/images/#{overlay_image}").first
    overlay.opacity = (Magick::TransparentOpacity-Magick::OpaqueOpacity) * 0.35

    source.composite!(overlay, Magick::CenterGravity, Magick::OverlayCompositeOp)

    filename = "#{user[:id]}_#{overlay_image}"
    source.write("app/assets/images/#{filename}")
  end

  def self.get_source_image user
    source = Magick::ImageList.new
    image_url = URI.parse(user[:image_url])
    image_url.scheme = 'https'
    urlimage = open(image_url)
    source.from_blob(urlimage.read).first
  end
end
