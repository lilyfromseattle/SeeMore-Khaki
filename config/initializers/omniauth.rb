Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["TWITTER_API_KEY"], ENV["TWITTER_API_SECRET"]
  {
    :secure_image_url => 'true',
    :image_size => 'original',
    :authorize_params => {
      :force_login => 'true',
      :lang => 'pt'
    }
  }

  provider :instagram, ENV["INSTAGRAM_CLIENT_ID"], ENV["INSTAGRAM_CLIENT_SECRET"]
  provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"]
  {
      :client_options => {
        :site => 'https://github.YOURDOMAIN.com/api/v3',
        :authorize_url => 'https://github.YOURDOMAIN.com/login/oauth/authorize',
        :token_url => 'https://github.YOURDOMAIN.com/login/oauth/access_token',
      }
    }
end
