class EventNotificationService < NotificationService

  def initialize(event)
    @event = event
  end
  attr_reader :event

  class << self

    def request_to_attend(event, attendee)
      new(event).request_to_attend(attendee)
    end

    def accepted_by_admin(event, attendee)
      new(event).accepted_by_admin(attendee)
    end

    def send_invitation(event, attendee)
      new(event).send_invitation(attendee)
    end

    def invitation_accepted(event, attendee)
      new(event).invitation_accepted(attendee)
    end
  end

  # Sending a request to admin to add him as attendee
  def request_to_attend(attendee)
    args = {
      event_id: event.id.to_s,
      event_name: event.name,
      event_thumb_url: event.thumb_url,
      attendee_name: attendee.display_name,
      attendee_id: attendee.id.to_s,
      attendee_thumb_url: attendee.thumb_url
    }
    event.user.notifications.create({
      args: args,
      message_type: 'event_request_to_attend'
    })
    delayed_mailer.send_request_to_attend(event, event.user, attendee).deliver_now
  end

  # When joining request has been accepted for the event
  def accepted_by_admin(attendee)
    args = {
      event_id: event.id.to_s,
      event_name: event.name,
      event_thumb_url: event.thumb_url,
      admin_id: event.user.id,
      admin_name: event.user.display_name,
      admin_thumb_url: event.user.thumb_url
    }
    attendee.notifications.create({
      args: args,
      message_type: 'event_accepted_by_admin'
    })
    delayed_mailer.send_joining_request_accepted(event, attendee).deliver_now
  end

  def send_invitation(attendee)
    args = {
      event_id: event.id.to_s,
      event_name: event.name,
      event_thumb_url: event.thumb_url,
      admin_id: event.user.id,
      admin_name: event.user.display_name,
      admin_thumb_url: event.user.thumb_url,
      attendee_name: attendee.display_name,
      attendee_id: attendee.id.to_s,
      attendee_thumb_url: attendee.thumb_url
    }
    attendee.notifications.create({
      args: args,
      message_type: 'event_send_invitation'
    })
    delayed_mailer.send_invitation_by_admin(event, event.user, attendee).deliver_now
  end

  def invitation_accepted(attendee)
    args = {
      event_id: event.id.to_s,
      event_name: event.name,
      event_thumb_url: event.thumb_url,
      admin_id: event.user.id,
      admin_name: event.user.display_name,
      admin_thumb_url: event.user.thumb_url,
      attendee_name: attendee.display_name,
      attendee_id: attendee.id.to_s,
      attendee_thumb_url: attendee.thumb_url
    }
    event.user.notifications.create({
      args: args,
      message_type: 'event_invitation_accepted'
    })
    delayed_mailer.send_invitation_accepted(event, event.user, attendee).deliver_now
  end

  private

  def delayed_mailer
    # EventMailer.delay_for(RACE_CONDITION_DELAY)
    EventMailer
  end
end
