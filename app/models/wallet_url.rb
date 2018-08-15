module WalletUrl
  HOSTS = {
    "public" => "https://stellar.expert/explorer/public/account",
    "testnet" => "https://stellar.expert/explorer/testnet/account"
  }

  def self.get(account)
    "#{HOSTS.fetch(Horizon.env)}/#{account}"
  end
end
