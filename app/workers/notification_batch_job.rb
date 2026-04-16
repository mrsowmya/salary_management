class NotificationBatchJob

  include Sidekiq::Worker

  sidekiq_options queue: :critical
  BATCH_SIZE = 1000

  def perform(user_ids)
    User.in_batches(of: BATCH_SIZE) do |relation|
      user_ids = relation.pluck(:id)

      NotificationWorker.perform_async(user_ids)
    end
  end
end