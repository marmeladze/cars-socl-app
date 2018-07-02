class PrivacyPreference
  include Mongoid::Document
  include Mongoid::Timestamps

  field :posts, type: Integer, default: 0 # 0 -> Anyone, 1 -> Followers only
  field :follow, type: Integer, default: 0
  field :timeline, type: Integer, default: 0
  field :comments, type: Integer, default: 0

  embedded_in :user
  validates :posts, :follow, :timeline, :comments,
    inclusion: { in: [0,1] }

  VISIBILITY = ['Anyone', 'Followers only']
end
