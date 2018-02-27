class UpdateNotificationCounter
  def self.call
    Sidekiq.redis do |connection|
      connection.incr(:delivered_notifications_count)
    end
  end
end
