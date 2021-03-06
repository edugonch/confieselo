Confieselo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  config.host = ActiveSupport::OrderedOptions.new 
  config.host.name = 'www.confieselo.com'

  config.facebook = ActiveSupport::OrderedOptions.new 
  config.facebook.api_id = "487714468021516"
  config.facebook.secret = "bdb672e677c306f93232f7ac81197b7e"
  config.facebook.access_token = "CAAGLZCUZCicZCABAOLYPYlDjZCTw8hb048ef9T7ZCqSVULl5CZBvBeAf68G0X0IISzoIUdCWIm6dSjZBGWf4qao3tHZB7SZCjiS8TZCWFjakVZAZBZCc08ZAZCMOyACv3Fj7y8MhLrUftZAnLwvhVzwLT6nwro4KvDxmzoA9a142hXCaBO2SFOVDwKZAL0DZANMu7qPZBWbGuIZD"
  config.facebook.pageid = "1496036087282923"

  config.emails = ActiveSupport::OrderedOptions.new 
  config.emails.general_notification = "psps@stage.confieselo.com"
  config.emails.feed_list = "feed@stage.confieselo.com"
  config.emails.api_key = "key-3ng4mjs-4hpxwcr38t-l12qfed0h3d42"

  config.recaptcha = ActiveSupport::OrderedOptions.new
  config.recaptcha.public = "6Le0JO8SAAAAAFkPYuejLAfQFfYHmAPkInSpfO-M"
  config.recaptcha.private = "6Le0JO8SAAAAAP5Ho171dMUjwK-Tm7nZ_RDunujT"


  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true  # ActionMailer Config
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :authentication => :plain,
    :address => "smtp.mailgun.org",
    :port => 587,
    :domain => "stage.confieselo.com",
    :user_name => "postmaster@stage.confieselo.com",
    :password => "Trre$553##54@@sdE"
  }
  config.action_mailer.raise_delivery_errors = true
  # Send email in development mode.
  config.action_mailer.perform_deliveries = true

end
