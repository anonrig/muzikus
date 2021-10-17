Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, ENV["GOOGLE_ID"], ENV["GOOGLE_SECRET"], 
	{ 
		scope: 'userinfo.email, userinfo.profile',
		hd: %w(sabanciuniv.edu alumni.sabanciuniv.edu nizipli.com)
	}
end

OmniAuth.config.allowed_request_methods = [:post]
