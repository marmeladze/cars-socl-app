require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MotorBrag
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.autoload_paths += %W(#{config.root}/app/models/entities)
    config.autoload_paths += %W(#{config.root}/app/models/posts)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.generators do |g|
      g.orm :mongoid
    end

    Mongoid.logger.level = Logger::DEBUG
    Mongo::Logger.logger.level = Logger::DEBUG

    config.action_mailer.default_url_options = { host: ENV["DEFAULT_URL"] }
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    
    config.action_mailer.smtp_settings = {
      address:              'email-smtp.eu-west-1.amazonaws.com',
      port:                 465,
      user_name:            ENV["SES_SMTP_USERNAME"],
      password:             ENV["SES_SMTP_PASSWORD"],
      authentication:       'login',
      enable_starttls_auto: true,
      tsl:                  true
    }
  end
end
