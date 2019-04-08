class EnqueueWatchersWithoutCursorJob < ApplicationJob
  def perform
    Watcher.without_cursor.find_each do |watcher|
      RetrieveMostRecentCursorJob.perform_later(watcher.id)
    end
  end
end
