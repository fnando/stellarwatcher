class UpdateNotificationCounter
  def self.call
    Stats.update_all("deliveries_count = deliveries_count + 1")
  end
end
