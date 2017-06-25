# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.default_url_options = {:host => 'localhost:3000'}
  config.action_mailer.smtp_settings = {
      :address => 'smtp.sendgrid.net',
      :port => 587,
      :authentication => :plain,
      :enable_starttls_auto => true,
      :user_name => 'huycuong0610',
      :password => 'Asd123321',
  }
