require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Alfonsoapp
  class Application < Rails::Application
    config.load_defaults 5.0
  end
end
