class ConfirmationToken
  def self.create(watcher_id)
    Parsel.encrypt(StellarWatcherApp::Config.encryption_secret_token, watcher_id)
  end

  def self.parse(encrypted_token)
    Parsel.decrypt(StellarWatcherApp::Config.encryption_secret_token, encrypted_token)
  end
end
