class EventsController < ApplicationController

  before_action :get_event, except: [:new, :create]

  def new
    @event = current_user.events.build
  end

  def create
    event = current_user.events.build(event_attrs)
    if event.save && event.send_invitations(params[:invited_user_ids])
      flash[:success] = 'Event Created successfully'
      set_current_entity(event)
      redirect_to event_path(event)
    else
      event.destroy
      render_with_error(event.errors.full_messages.join(','), 422)
    end
  end

  def edit
    set_current_entity(@event)
  end

  def update
    if @event.update_attributes(event_attrs)
      flash[:success] = "Updated event profile successfully"
      redirect_to event_path(@event)
    else
      flash[:error] = "Failed to update event profile"
      render_with_error(@event.errors.full_messages.join(','), 422)
    end
  end

  def show
    if @event.private? && !@event.members.include?(current_user)
      flash[:notice] = "You are not authorized to see this page."
      redirect_to root_path
    end
    set_current_entity(@event)
  end

  def attend
    @event.add_attendee(current_user)
    flash[:success] = "You are attending #{@event.name} event."
    redirect_back(fallback_location: root_path)
  end

  def drop
    @event.drop_attendee(current_user)
    flash[:success] = "You are removed from #{@event.name} event."
    redirect_back(fallback_location: root_path)
  end

  def upload_pic
    if @event.update_attributes(event_pic_attrs)
      flash[:success] = "Updated pic successfully"
    else
      flash[:error] = "Failed to update pic"
    end
    redirect_to event_path(@event)
  end


  def join_request
    invitation = @event.send_join_request(current_user)
    if invitation
      flash[:success] = "Invitation has been send to event admin successfully"
      redirect_back(fallback_location: root_path)
    else
      render_with_error(invitation.errors.full_messages.join(','), 422)
    end
  end

  def send_invitations
    if @event.send_invitations(params[:invited_user_ids])
      flash[:success] = "Invitations has been sent successfully"
      redirect_to event_path(@event)
    else
      render_with_error(invitation.errors.full_messages.join(','), 422)
    end
  end

  def accept_request
    if @event.accept_join_request(params.require(:attendee_id))
      flash[:success] = "Invitation has been accepted successfully"
    else
      flash[:error] = "Error while accepting the request"
    end
    redirect_to event_path(id: @event.id, anchor: 'attendees')
  end

  def accept_invitation
    invitation = @event.accept_invitation(current_user)
    if invitation
      flash[:success] = "Invitation has been accepted successfully"
      redirect_back(fallback_location: root_path)
    else
      render_with_error(invitation.errors.full_messages.join(','), 422)
    end
  end

  private

  def event_attrs
    params.require(:event).permit(:phone, :email, :website, :location, :event_date,
      :event_type, admin_user_ids: [],
      profile_attributes: [:name, :about, :avatar, :cover_pic],
      photos_attributes: [:id, :file, :_destroy],
      address_attributes: [:address],
      categories_attributes: [:name, :make, :model]
    )
  end

  def event_pic_attrs
    params.require(:event).permit(
      profile_attributes: [:avatar, :cover_pic]
    )
  end

  def get_event
    @event ||= Event.find(params[:id])
  end
end
