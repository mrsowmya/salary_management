# app/services/notification_service.rb
class NotificationService
  def self.send_notification(user)
    # Example: email
    NotificationMailer.notify(user).deliver_now
  rescue => e
    Rails.logger.error("Failed for #{user.id}: #{e.message}")
  end
end