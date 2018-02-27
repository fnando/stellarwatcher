class NotifyWebhookJob < ApplicationJob
  def perform(webhook_url, transaction_hash)
    HttpClient.post do
      url webhook_url
      params transaction_hash: transaction_hash
      options expect: 202
    end

    UpdateNotificationCounter.call
  end
end
