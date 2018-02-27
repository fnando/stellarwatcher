class NotifyWebhookJob < ApplicationJob
  def perform(webhook_url, operation_id)
    HttpClient.post do
      url webhook_url
      params operation_id: operation_id
      options expect: 202
    end

    UpdateNotificationCounter.call
  end
end
