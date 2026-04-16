# app/middleware/sidekiq_rate_limit_middleware.rb
class SidekiqRateLimitMiddleware
  RATE_LIMIT = 500 # jobs/sec
  WINDOW = 1

  def call(worker, job, queue)
    limiter = RateLimiter.new
    key = "rate_limit:sidekiq:global"

    unless limiter.allow?(key, limit: RATE_LIMIT, window: WINDOW)
      # requeue job
      worker.class.perform_in(1.second, *job["args"])
      return
    end

    yield
  end
end