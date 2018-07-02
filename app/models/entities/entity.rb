class Entity
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  embeds_one :profile, as: :details, cascade_callbacks: true
  embeds_many :categories, as: :categorizable
  embeds_many :photos, as: :photographic, cascade_callbacks: true
  embeds_many :videos, as: :videographic, cascade_callbacks: true

  has_many :posts, as: :postable
  has_many :blog_posts, as: :postable, class_name: 'BlogPost'
  has_many :photo_posts, as: :postable, class_name: 'PhotoPost'
  has_many :video_posts, as: :postable, class_name: 'VideoPost'
  has_many :text_posts, as: :postable, class_name: 'TextPost'

  accepts_nested_attributes_for :profile, allow_destroy: true
  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: proc {|attrs|  attrs.values.any?(&:blank?) }
  delegate :name, :about, :avatar, :cover_pic, to: :profile, allow_nil: true

  def thumb_url
    return '../assets/avatars/default_avatar.png' unless profile
    profile.try(:avatar).try(:thumb).try(:url)
  end
end
