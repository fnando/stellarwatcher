class GetNotificationCount
  def self.call
    Sidekiq.redis do |connection|
      Integer(connection.get(:delivered_notifications_count) || 0)
    end
  end
end
