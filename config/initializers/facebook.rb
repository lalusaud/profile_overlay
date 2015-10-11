if Rails.env.development? or Rails.env.test?
  YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
end
