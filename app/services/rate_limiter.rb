class RateLimiter

  def initialize(redis = $redis)
    @redis = redis
  end

  def allow?(key, limit:, window:)
    current = @redis.get(key).to_i

    if current < limit
      @redis.multi do |pipeline|
        pipeline.incr(key)
        pipeline.expire(key, window) if current == 0
      end
      true
    else
      false
    end
  end

  def remaining(key, limit)
    limit - @redis.get(key).to_i
  end
end