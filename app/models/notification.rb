class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  field :args, type: Hash
  field :message_type, type: String

  belongs_to :user
  after_create :update_user_details
  default_scope -> { order("created_at DESC") }

  private
  def update_user_details
    user.unread_notifications_count += 1
    user.unread_notification_ids << self.id
    user.save
  end
end
