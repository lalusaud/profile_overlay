if Rails.env.development?
  YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
end
