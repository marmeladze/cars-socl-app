class NotificationsController < ApplicationController

  def index
    current_user.update_attributes(unread_notifications_count: 0)
    @notifications = current_user.notifications
  end
end
