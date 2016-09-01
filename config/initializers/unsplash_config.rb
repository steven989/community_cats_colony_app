Unsplash.configure do |config|    
  config.application_id     = ENV['UNSPLASH_APPLICATION_ID']
  config.application_secret = ENV['UNSPLASH_APPLICATION_SECRET']
  # config.application_redirect_uri = "https://your-application.com/oauth/callback"
end