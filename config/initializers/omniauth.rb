OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["facebook_id"], ENV["facebook_secret"], {:scope => "email, user_birthday, publish_actions"}
end