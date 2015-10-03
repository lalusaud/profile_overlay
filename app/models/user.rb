class User < ActiveRecord::Base

  def self.from_omniauth(auth_hash)
    user = User.new
    user.id = auth_hash['uid']
    user.name = auth_hash['info']['name']
    user.location = auth_hash['info']['location']
    user.image_url = auth_hash['info']['image']
    # user.save!
    user
  end
end
