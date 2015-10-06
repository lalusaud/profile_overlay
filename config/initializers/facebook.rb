if Rails.env.development? or Rails.env.test?
  ENV = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
end
