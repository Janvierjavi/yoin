require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Yoin
  class Application < Rails::Application
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.load_defaults 5.2

    # add custom validators path
    config.autoload_paths += Dir["#{config.root}/app/validators"]

    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"

      config.action_view.field_error_proc = Proc.new do |html_tag, instance| 
        html_tag
      end
    end
  end
end
