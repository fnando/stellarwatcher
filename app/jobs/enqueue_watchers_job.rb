class EnqueueWatchersJob < ApplicationJob
  def perform
    Watcher.to_be_enqueued.find_each do |watcher|
      RunWatcherJob.perform_later(watcher.id)
    end
  end
end
