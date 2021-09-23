ruby "~> 2.6.8"
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
gem 'sprockets'
# Active record Session
gem 'activerecord-session_store'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Google Login

gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

gem 'certified'
gem 'jwt'
gem 'simple_command'
#instagram gallery
gem 'instagram'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-script-source'
gem 'coffee-rails'
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
gem 'json'
# For use of environment variables
gem 'faker', :groups => [:development, :production]
gem 'paperclip'
gem 'aws-sdk'
gem 'pg'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen'
end
