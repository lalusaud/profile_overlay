Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? or Rails.env.test?
    app_id = FACEBOOK_CONFIG['app_id']
    secret = FACEBOOK_CONFIG['secret']
  else
    app_id = ENV['app_id']
    secret = ENV['secret']
  end

  provider :facebook, app_id, secret, {scope: 'publish_actions'}
end
