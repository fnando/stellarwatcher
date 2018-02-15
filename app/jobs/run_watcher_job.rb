class RunWatcherJob < ApplicationJob
  def perform(watcher_id)
    watcher = Watcher.find(watcher_id)
    cursor, operations = Horizon.operations(watcher.wallet_address, cursor: watcher.cursor)

    watcher.cursor = cursor
    watcher.next_fetch = 1.hour.from_now

    return watcher.save! unless operations.any?

    last_result_at = operations
                      .map {|operation| Time.parse(operation["created_at"]) }
                      .sort
                      .last

    since = watcher.last_result_at
    watcher.last_result_at = last_result_at
    watcher.save!
    Mailer.notify(watcher.id, since.iso8601, operations.size).deliver_later
  end
end
