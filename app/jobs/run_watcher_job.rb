class RunWatcherJob < ApplicationJob
  def perform(watcher_id)
    watcher = Watcher.find(watcher_id)
    cursor, operations = Horizon.operations(watcher.wallet_address, cursor: watcher.cursor)

    watcher.cursor = cursor
    watcher.next_fetch = 1.hour.from_now
    since = watcher.last_result_at

    return watcher.save! unless operations.any?

    last_result_at = operations
                      .map {|operation| Time.parse(operation["created_at"]) }
                      .sort
                      .last

    webhook_url = watcher.webhook_url

    operations.each do |operation|
      NotifyWebhookJob.perform_later(webhook_url, operation["id"])
    end if webhook_url

    Mailer.notify(watcher.id, since.iso8601, operations.size).deliver_later

    watcher.last_result_at = last_result_at
    watcher.save!
  end
end
