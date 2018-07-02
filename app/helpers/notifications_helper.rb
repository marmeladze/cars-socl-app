module NotificationsHelper

  def get_notification_item(notification)
    case notification.message_type
    when 'event_accepted_by_admin'
      'notifications/events/accepted_by_admin'
    when 'event_request_to_attend'
      'notifications/events/request_to_attend'
    when 'event_send_invitation'
      'notifications/events/sending_invitation'
    when 'event_invitation_accepted'
      'notifications/events/invitation_accepted'
    end
  end

  def new_notification_klass(notification_id)
    'new' if current_user.unread_notification_ids.include?(notification_id)
  end
end
