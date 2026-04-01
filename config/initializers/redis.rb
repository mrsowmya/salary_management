# config/initializers/redis.rb
require 'redis'

$redis = Redis.new(
  url: ENV.fetch("REDIS_URL", "redis://localhost:6379/1"),
  reconnect_attempts: 2,
  timeout: 1
)