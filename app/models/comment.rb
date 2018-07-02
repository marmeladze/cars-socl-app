class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String

  embedded_in :commentable, polymorphic: true
  embeds_one :user, class_name: 'User'
  has_and_belongs_to_many :likers, class_name: 'User', inverse_of: nil
  embeds_many :replies, class_name: 'Comment'

  validates :body, presence: true

  def add_like(usr)
    likers << usr unless is_liked_by?(usr)
  end

  def dislike(usr)
    likers.delete(usr) if is_liked_by?(usr)
  end

  def random_liker
    likers.sample
  end

  def is_liked_by?(usr)
    likers.include?(usr)
  end
end
