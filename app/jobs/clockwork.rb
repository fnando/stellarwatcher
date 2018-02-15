require "./config/boot"
require "./config/environment"

module Clockwork
  handler do |job|
    EnqueueWatchersJob.perform_later
  end

  every(1.minute, "enqueue_watchers")
end
