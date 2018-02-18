# Check https://github.com/twitter/secureheaders for documentation.

Rails.env.on(:development) do
  SecureHeaders::Configuration.default do |config|
    config.csp[:default_src] = %w['self']
    config.csp[:script_src] = %w['self' 'unsafe-eval']
    config.csp[:script_src] = %w[
      'self'
      'unsafe-eval'
      'unsafe-inline'
      https://www.googletagmanager.com
    ]
  end
end

Rails.env.on(:test, :production) do
  SecureHeaders::Configuration.default do |config|
    config.csp[:default_src] = %w['self']
    config.csp[:script_src] = %w[
      'self'
      'unsafe-inline'
      https://www.googletagmanager.com
    ]
  end
end
