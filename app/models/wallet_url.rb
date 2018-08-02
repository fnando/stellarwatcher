module WalletUrl
  HOSTS = {
    "public" => "https://steexp.com",
    "testnet" => "https://testnet.steexp.com"
  }

  def self.get(account)
    "#{HOSTS.fetch(Horizon.env)}/account/#{account}#payments"
  end
end
