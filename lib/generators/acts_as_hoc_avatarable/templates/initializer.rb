ActsAsHocAvatarable.configure do |config|
  config.default_host = "localhost:3000"
  config.resize_on_create = true
  config.resize_size = "100x100>"
  config.fallback_to_gravatar = true
end
