Rails.env.on(:production) do
  config.active_job.queue_adapter = :sidekiq
end
