class Company < Entity

  field :phone, type: String
  field :email, type: String
  field :website, type: String
  field :admin_user_ids, type: Array, default: []

  embeds_one :address, as: :addressable
  accepts_nested_attributes_for :address, allow_destroy: true
  delegate :city, to: :address

  has_and_belongs_to_many :followers, class_name: 'User', inverse_of: :following_companies

  def location
    address.try(:address)
  end

  def admin_users
    User.find(admin_user_ids) + [user]
  end
end
