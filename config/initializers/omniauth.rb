Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, ENV["GOOGLE_ID"], ENV["GOOGLE_SECRET"], 
	{ 
		:scope => 'email,profile',
		:hd => 'sabanciuniv.edu'
	}
end