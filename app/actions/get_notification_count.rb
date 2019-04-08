class GetNotificationCount
  def self.call
    stats = Stats.first!
    stats.deliveries_count
  end
end
