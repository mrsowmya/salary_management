class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :rate_limit_user

  private

  def rate_limit_user
    limiter = RateLimiter.new

    identifier = request.ip
    key = "rate_limit:ip:#{identifier}"

    limit = 200
    window = 60

    unless limiter.allow?(key, limit: limit, window: window)
      render json: { error: "User rate limit exceeded" }, status: 429
    end
  end
end
