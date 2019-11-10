ruby "~> 2.6.3"
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
gem 'sprockets', '~>3.7.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5', :groups => [:development, :test]
# Active record Session
gem 'activerecord-session_store'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Google Login
gem 'omniauth-google-oauth2', "~> 0.6.0"
gem 'certified'
#instagram gallery
gem 'instagram'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-script-source', '1.8.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'json'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# For use of environment variables
gem 'dotenv-rails', :groups => [:development, :test]
gem 'faker', :groups => [:development, :production]
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'paperclip', '4.2.0'
gem 'aws-sdk', '~> 1.59.1'

group :production do
  gem 'pg'
#  gem 'rails_12factor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
#  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
