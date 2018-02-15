class RetrieveMostRecentCursorJob < ApplicationJob
  def perform(watcher_id)
    watcher = Watcher.find(watcher_id)
    cursor, operation = Horizon.most_recent_operation(watcher.wallet_address)

    watcher.cursor = cursor
    watcher.last_result_at = Time.parse(operation["created_at"])
    watcher.next_fetch = 1.hour.from_now
    watcher.save!
  end
end
