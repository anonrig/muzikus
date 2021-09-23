require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Alfonsoapp
  class Application < Rails::Application
    config.load_defaults 6.1
    config.generators.system_tests = nil
  end
end
