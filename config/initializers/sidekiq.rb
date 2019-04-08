Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  # Protect against timing attacks:
  # - See https://codahale.com/a-lesson-in-timing-attacks/
  # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
  # - Use & (do not use &&) so that it doesn't short circuit.
  # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(StellarWatcherApp::Config.sidekiq_username)) &
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(StellarWatcherApp::Config.sidekiq_password))
end if Rails.env.production?

Sidekiq::Clockwork.run do
  every(1.minute) { EnqueueWatchersJob.perform_later }
  every(1.hour) { RemoveUnconfirmedWatchersJob.perform_later }
end
