HttpClient = Aitch::Namespace.new
HttpClient.configure do |config|
  config.user_agent = "StellarWatcher/#{Aitch::VERSION}"
end
