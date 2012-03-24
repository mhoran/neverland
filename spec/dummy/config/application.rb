require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require 'sprockets/railtie'
require 'jquery/rails'

Bundler.require
require "neverland"

module Dummy
  class Application < Rails::Application
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Log error messages when you accidentally call methods on nil
    config.whiny_nils = true

    # Show full error reports and disable caching
    config.consider_all_requests_local       = true
    config.action_controller.perform_caching = false

    # Raise exceptions instead of rendering exception templates
    config.action_dispatch.show_exceptions = false

    # Disable request forgery protection in test environment
    config.action_controller.allow_forgery_protection    = false

    # Print deprecation notices to the stderr
    config.active_support.deprecation = :stderr

    config.middleware.use Neverland::Middleware
  end
end

