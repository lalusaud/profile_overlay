class User < ActiveRecord::Base

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.uid = auth_hash['uid']
    user.name = auth_hash['info']['name']
    user.image_url = auth_hash['info']['image']
    user.token = auth_hash['credentials']['token']
    user.save!
    user
  end

  def delete_images
    images = Overlay.images
    images.each do |image|
      file_path = "app/assets/images/users/#{uid}_#{image}"
      File.delete file_path if File.exists? file_path
    end
  end
end
