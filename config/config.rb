module StellarWatcherApp
  Config = Env::Vars.new do
    # Set the database connection string.
    mandatory :database_url, string

    # Force the request to this particular controller or specified actions to be
    # under HTTPS protocol.
    optional :force_ssl, bool, false

    # Set the application environment.
    optional :rails_env, "development", string, aliases: %w[env]

    # Set the time zone of your application.
    optional :tz, string, "Etc/UTC"

    # Set the asset host, e.g. AWS CloudFront.
    optional :asset_host, string

    # Set the encryption secret token.
    mandatory :encryption_secret_token, string

    # Set the horizon environment.
    mandatory :horizon_environment, string

    # Set sidekiq creds.
    optional :sidekiq_username, string
    optional :sidekiq_password, string
  end
end
