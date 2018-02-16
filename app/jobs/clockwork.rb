require "./config/boot"
require "./config/environment"

module Clockwork
  handler do |job|
    case job
    when "enqueue_watchers"
      EnqueueWatchersJob.perform_later
    when "remove_unconfirmed_watchers"
      RemoveUnconfirmedWatchersJob.perform_later
    end
  end

  every(1.minute, "enqueue_watchers")
  every(1.hour, "remove_unconfirmed_watchers")
end
