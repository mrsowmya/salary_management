# app/middleware/rate_limit_middleware.rb
class RateLimitMiddleware
  def initialize(app)
    @app = app
    @limiter = RateLimiter.new
  end

  def call(env)
    request = Rack::Request.new(env)

    key = "rate_limit:global:#{request.ip}"
    limit = 1000   # requests
    window = 60   # seconds

    allowed = @limiter.allow?(key, limit: limit, window: window)

    unless allowed
      return [
        429,
        { "Content-Type" => "application/json" },
        [{ error: "Rate limit exceeded" }.to_json]
      ]
    end

    @app.call(env)
  end
end