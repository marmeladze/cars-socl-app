class CommentsController < ApplicationController
  before_action :assign_comment, only: %i[destroy]

  def destroy
    @comment.destroy if @comment.present?
  end

  private

  def assign_comment
    post = Post.find(params.require(:post_id))
    @comment = post.comment_by_id(params.require(:comment_id))
  end
end
