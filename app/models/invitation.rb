class Invitation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: Boolean, default: false
  field :invited, type: Boolean, default: false # true -> if the invitation has been created by admin

  belongs_to :event
  belongs_to :user

  scope :pending, -> { where(status: false) }
  validates :event_id, uniqueness: { scope: [:user_id] }
  
  def accept!
    update_attributes(status: true)
    event.add_attendee(user)
  end
end
