class Event < Entity

  field :phone, type: String
  field :email, type: String
  field :website, type: String
  field :event_type, type: Integer, default: 0 # 0 -> Open, 1 -> by_request, 2 -> private
  field :admin_user_ids, type: Array, default: []
  field :event_date, type: Date
  
  validates :event_type, inclusion: { in: [0, 1, 2] }

  embeds_one :address, as: :addressable
  accepts_nested_attributes_for :address, allow_destroy: true
  has_and_belongs_to_many :attendees, class_name: 'User', inverse_of: :attending_events
  delegate :city, to: :address

  has_many :invitations

  def display_date
    return if event_date.nil?
    time = Time.parse(event_date.to_s)
    time.strftime('%B %d')
  end

  def location
    address.try(:address)
  end

  def admin_users
    User.find(admin_user_ids) + [user]
  end

  def members
    admin_users + attendees
  end

  def is_member?(usr)
    members.include?(usr)
  end

  def public?
    event_type == 0
  end

  def private?
    event_type == 2
  end

  def on_request?
    event_type == 1
  end

  def is_attending?(usr)
    attendees.include?(usr)
  end

  def add_attendee(usr)
    return if is_attending?(usr)
    attendees << usr
  end

  def drop_attendee(usr)
    return unless is_attending?(usr)
    attendees.delete(usr)
  end

  def send_join_request(usr)
    invitation = add_invitation(usr)
    EventNotificationService.request_to_attend(self, usr)
    invitation
  end

  def accept_join_request(usr_id)
    invitation = invitations.where(user_id: usr_id).first
    return if invitation.nil?
    invitation.accept!
    attendee = User.find(usr_id)
    EventNotificationService.accepted_by_admin(self, attendee)
    invitation
  end

  def has_pending_invitation?(usr_id)
    inv = invitations.where(user_id: usr_id, invited: true, status: false).first
    inv.present?
  end

  def send_invitations(usr_ids)
    return true if usr_ids.nil?
    usr_ids.each do |usr_id|
      invitation = invitations.find_or_initialize_by(user_id: usr_id, invited: true)
      invitation.status = false
      invitation.save
      attendee = User.find(usr_id)
      EventNotificationService.send_invitation(self, attendee)
    end
  end

  def accept_invitation(usr)
    invitation = invitations.where(user_id: usr.id.to_s, invited: true).first
    return if invitation.nil?
    invitation.accept!
    EventNotificationService.invitation_accepted(self, usr)
    invitation
  end

  private
  def add_invitation(usr)
    invitation = invitations.find_or_initialize_by(user_id: usr.id.to_s)
    invitation.status = false
    invitation.save
  end
end
