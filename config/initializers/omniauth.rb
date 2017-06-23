 OmniAuth.config.logger = Rails.logger

  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '1904684199776605', '40b31e0c45b6c703266a2105cf0d15e0'
  end