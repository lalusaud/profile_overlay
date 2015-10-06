Rails.application.config.middleware.use OmniAuth::Builder do
    app_id = ENV['app_id']
    secret = ENV['secret']

    provider :facebook, app_id, secret, scope: 'publish_actions',
                :image_size => {width: 500, height: 500}
end
