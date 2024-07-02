require_relative "boot"

require "rails"

require "action_controller/railtie"
require "action_view/railtie"
require "active_job/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module Metube
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w(assets tasks))
    config.generators.system_tests = nil
  end
end
