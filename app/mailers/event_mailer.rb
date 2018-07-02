class EventMailer < ApplicationMailer

  def send_request_to_attend(event, admin, attendee)
    @event = event
    @admin = admin
    @attendee = attendee
    mail(subject: "Request from #{attendee.display_name} to attend event #{event.name}", to: @admin.email)
  end

  def send_joining_request_accepted(event, attendee)
    @event = event
    @attendee = attendee
    mail(subject: "Now you are attending event: #{event.name}", to: @attendee.email)
  end

  def send_invitation_by_admin(event, admin, attendee)
    @event = event
    @admin = admin
    @attendee = attendee
    mail(subject: "You are being invited to attend event: #{event.name}", to: @attendee.email)
  end

  def send_invitation_accepted(event, admin, attendee)
    @event = event
    @admin = admin
    @attendee = attendee
    mail(subject: "#{attendee.display_name} has accepted invitation to event: #{event.name}", to: @admin.email)
  end
end
