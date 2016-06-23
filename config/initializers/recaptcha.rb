Recaptcha.configure do |config|
  config.public_key  = Rails.configuration.recaptcha.public
  config.private_key = Rails.configuration.recaptcha.private
end
