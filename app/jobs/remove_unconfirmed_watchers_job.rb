class RemoveUnconfirmedWatchersJob < ApplicationJob
  def perform
    Watcher.to_be_purged.find_each do |watcher|
      watcher.destroy!
    end
  end
end
