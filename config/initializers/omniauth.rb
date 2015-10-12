OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '151206855076651', '0968d5b3cf0f8ec4b4989f8234d3f8fb', {:scope => "email, user_birthday, publish_actions"}
end