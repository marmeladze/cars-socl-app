class User
  include Mongoid::Document
  include Mongoid::Timestamps
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  ## Database authenticatable
  field :name,               type: String
  field :username,           type: String
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String
  field :provider,           type: String
  field :uid,                type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  # attr_accessible :email, :password, :password_confirmation, :remember_me

  field :known_by, type: String, default: 'username'
  field :rating, type: Integer, default: 0
  field :country, type: String
  field :country_code, type: String
  field :state, type: String
  field :state_code, type: String
  field :city, type: String
  field :legacy_contact_name, type: String
  field :legacy_contact_email, type: String
  field :unread_notifications_count, type: Integer, default: 0
  field :unread_notification_ids, type: Array, default: []

  validates :username, :email, presence: true, uniqueness: true

  after_create :set_associated_objects

  has_many :companies
  has_many :events
  has_many :groups
  has_many :motors
  has_one :dream_garage
  embeds_one :profile, as: :details, cascade_callbacks: true
  accepts_nested_attributes_for :profile, allow_destroy: true
  delegate :about, :avatar, :cover_pic, to: :profile

  embeds_one :email_preference, cascade_callbacks: true
  embeds_one :app_preference, cascade_callbacks: true
  embeds_one :privacy_preference, cascade_callbacks: true

  embeds_many :photos, as: :photographic, cascade_callbacks: true
  embeds_many :videos, as: :videographic, cascade_callbacks: true

  has_many :posts, as: :postable
  has_many :blog_posts, as: :postable, class_name: 'BlogPost'
  has_many :photo_posts, as: :postable, class_name: 'PhotoPost'
  has_many :video_posts, as: :postable, class_name: 'VideoPost'
  has_many :text_posts, as: :postable, class_name: 'TextPost'

  has_and_belongs_to_many :followers, class_name: 'User', inverse_of: nil
  has_and_belongs_to_many :follows, class_name: 'User', inverse_of: nil
  has_and_belongs_to_many :following_motors, class_name: 'Motor'
  has_and_belongs_to_many :following_companies, class_name: 'Company'
  has_and_belongs_to_many :attending_events, class_name: 'Event'

  has_many :notifications

  STATUS = ['New Member', 'Junior Member', 'Full Member', 'Senior Member', 'Elite Member']

  def display_name
    name || email
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.username = auth.info.name
    end
  end

  def all_motors
    motors + dream_garage.motors
  end

  def user_status
    STATUS[rating]
  end

  def self.search(key, current_user)
    return [] if key.blank?
    results = any_of({name: /#{key}/i}, {username: /#{key}/i}, {email: /#{key}/i})
      .where(:_id.ne => current_user.id)
    results.map do |user|
      {
        id: user.id.to_s,
        display_name: user.display_name,
        name: user.name,
        email: user.email,
        thumb_url: user.thumb_url,
        city: user.city
      }
    end
  end

  def thumb_url
    return '../assets/avatars/default_avatar.png' unless profile
    profile.try(:avatar).try(:thumb).try(:url)
  end

  def follow_user?(usr)
    follows.include?(usr)
  end

  def follow_user(usr)
    self.follows << usr
    usr.followers << self
  end

  def unfollow_user(usr)
    return unless follow_user?(usr)
    follows.delete(usr)
    usr.followers.delete(self)
  end

  def follow_motor(motor)
    return if motor.user == self
    self.following_motors << motor
    motor.followers << self
  end

  def follow_motor?(motor)
    following_motors.include?(motor)
  end

  def unfollow_motor(motor)
    return unless follow_motor?(motor)
    following_motors.delete(motor)
    motor.followers.delete(self)
  end

  def follow_company(company)
    return if company.user == self
    self.following_companies << company
    company.followers << self
  end

  def follow_company?(company)
    following_companies.include?(company)
  end

  def unfollow_company(company)
    return unless follow_company?(company)
    following_companies.delete(company)
    company.followers.delete(self)
  end

  ['user', 'motor', 'company'].each do |action|
    # define_method
  end

  private

  def set_associated_objects
    create_profile
    create_dream_garage
    create_email_preference
    create_app_preference
    create_privacy_preference
  end

  def self.no_results_html(empty_search=false)
    msg = empty_search ? 'Enter key to search users' : 'No results found'
    [{
      html_content: "<div class='list-item text-danger'>#{msg}</div>"
    }]
  end
end
