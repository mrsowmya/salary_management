class NotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: :mailers, retry: 5

  def perform(user_ids)
    users = User.where(id: user_ids)

    RATE_LIMIT = 100
    WINDOW = 1

    limiter = RateLimiter.new

    users.each do |user|
      key = "rate_limit:notifications"

      unless limiter.allow?(key, limit: RATE_LIMIT, window: WINDOW)
        # Retry later instead of dropping
        self.class.perform_in(1.second, [user.id])
        next
      end

      
      NotificationService.send_notification(user)
    end
  end
end


Trigger Job
   ↓
Batch Job (splits 1M users → 1000 batches)
   ↓
Enqueue 1000 jobs
   ↓
Sidekiq pulls jobs from Redis
   ↓
Workers process in parallel
   ↓
Notification sent