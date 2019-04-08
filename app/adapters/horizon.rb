class Horizon
  HORIZON_ENDPOINTS = {
    "public" => "https://horizon.stellar.org",
    "testnet" => "https://horizon-testnet.stellar.org"
  }

  def self.env
    StellarWatcherApp::Config.horizon_environment
  end

  def self.endpoint
    HORIZON_ENDPOINTS.fetch(env)
  end

  def self.most_recent_operation(wallet_address)
    cursor, results = operations(wallet_address, limit: 1, order: "desc", continue: -> { false })
    [cursor, results.first]
  end

  def self.operations(wallet_address, cursor: nil, limit: 100, order: "asc", continue: -> { true })
    results = []

    loop do
      fetched_results = false
      url = "#{endpoint}/accounts/#{wallet_address}/operations"

      params = {limit: limit, order: order, options: {expect: 200}}
      params[:cursor] = cursor if cursor

      response = Aitch.get(url, params)
      data = response.data.dig("_embedded", "records")

      data&.each do |operation|
        cursor = Integer(operation["paging_token"])
        fetched_results = true
        results << operation
      end

      break unless fetched_results
      break unless continue.call
    end

    [cursor, results]
  end
end
