# config/initializers/sidekiq.rb

require 'sidekiq'
# config/initializers/sidekiq.rb

redis_url = ENV['REDIS_URL'] || 'redis://localhost:6380/0'

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end



# If you're using Sidekiq's web interface, you might also want to set up authentication:
# require 'sidekiq/web'
# Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
#   [user, password] == ["your_username", "your_password"]
# end
