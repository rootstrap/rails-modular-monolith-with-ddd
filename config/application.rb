require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsModularMonolithWithDdd
  class Application < Rails::Application
    PATHS = ['app', 'app/controllers', 'app/channels', 'app/helpers', 'app/models', 'app/mailers', 'app/views',
             'lib', 'lib/tasks', 'config', 'config/locales', 'config/initializers'].freeze

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.action_mailer.default_url_options = { host: ENV['SERVER_HOST'], port: 3000 }

    Dir.glob('components/*').each do |component_root|
      PATHS.each do |path|
        config.paths[path] << Rails.root.join(component_root, path)
      end
    end
  end
end
