require_relative "boot"

require "rails/all"
require 'kaminari'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Content
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.hosts << "test-publisher.localhost.com"

    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
     "<div class='your class'>#{html_tag}</div>".html_safe
    }
  end
end
