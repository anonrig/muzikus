OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["facebook_id"], ENV["facebook_secret"], {
  			scope: 'https://www.googleapis.com/auth/userinfo.profile, https://www.googleapis.com/auth/userinfo.email, https://mail.google.com/, https://www.googleapis.com/auth/admin.directory.user.readonly',
            prompt: 'select_account consent',
            access_type: 'offline',
	        callback_path: '/auth/google_oauth2/callback'}

end