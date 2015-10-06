class Overlay
  def self.create_image source, overlay_image, user
    source = source.resize_to_fill(500, 500)

    overlay = Magick::Image.read("app/assets/images/#{overlay_image}").first
    intermediate = source.composite(overlay, Magick::CenterGravity, Magick::SrcOverCompositeOp)
    intermediate.opacity = (Magick::TransparentOpacity-Magick::OpaqueOpacity) * 0.45
    source.composite!(intermediate, Magick::CenterGravity, Magick::SrcOverCompositeOp)

    filename = "#{user.uid}_#{overlay_image}"
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
