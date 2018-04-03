require "instagram"

Instagram.configure do |config|
	config.access_token=ENV["INSTA_TOKEN"]
end