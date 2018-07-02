class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String

  belongs_to :postable, polymorphic: true
  has_and_belongs_to_many :likers, class_name: 'User', inverse_of: nil
  embeds_many :comments, as: :commentable

  default_scope -> { order('created_at DESC') }
  validates :body, presence: true

  def posted_by
    postable.is_a?(User) ? postable : postable.user
  end

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

  def user
    postable if postable.is_a?(User)
  end

  def all_comments
    all = comments
    comments.each do |comment|
      all += comment.replies
    end
    all.flatten
  end

  def comment_by_id(cid)
    all_comments.select {|x| x.id.to_s == cid}.first
  end
end
