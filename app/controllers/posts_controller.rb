class PostsController < ApplicationController

  def new
    render layout: false
  end

  def show
    @post = post
  end

  def create
    post = post_objects.build(post_attrs)
    if post.save
      flash.now[:notice] = 'Post Created successfully'
      render partial: 'index', layout: false,
        locals: {posts: post_objects}
    else
      render_with_error(post.errors.full_messages.join(','), 422)
    end
  end

  def like
    if post.add_like(current_user)
      render partial: 'posts/post_likes_info',
        locals: { post: post.reload }, layout: false
    else
      render_with_error('Error while processing request', 422)
    end
  end

  def dislike
    if post.dislike(current_user)
      render partial: 'posts/post_likes_info',
        locals: { post: post.reload }, layout: false
    else
      render_with_error('Error while processing request', 422)
    end
  end

  def create_comment
    comment = post.comments.build(comment_attrs)
    comment.user = current_user
    if comment.save
      post.reload
      render partial: 'posts/comments', layout: false,
        locals: { post: post, comments: post.comments }
    else
      render_with_error('Error while processing request', 422)
    end
  end

  def add_reply
    reply = comment.replies.build(comment_attrs)
    reply.user = current_user
    if reply.save
      post.reload
      render partial: 'posts/comments', layout: false,
        locals: { post: post, comments: post.comments }
    else
      render_with_error('Error while processing request', 422)
    end
  end

  def like_comment
    if comment.add_like(current_user)
      comment.reload
      render partial: 'posts/comment_likes_info',
        locals: { post: post, comment: comment }, layout: false
    else
      render_with_error('Error while processing request', 422)
    end
  end

  def dislike_comment
    if comment.dislike(current_user)
      comment.reload
      render partial: 'posts/comment_likes_info',
        locals: { post: post, comment: comment }, layout: false
    else
      render_with_error('Error while processing request', 422)
    end
  end

  private

  def post
    @post ||= Post.find(params.require(:id))
  end

  def comment
    @comment ||= post.comment_by_id(params.require(:comment_id))
  end

  def post_attrs
    params.require(:post).permit(:body, photo_attributes: [:id, :file, :_destroy])
  end

  def post_objects
    current_entity.send(post_type)
  end

  def post_type
    if params[:post] && params[:post][:type].eql?('blog_post')
      'blog_posts'
    elsif post_attrs[:photo_attributes].present?
      'photo_posts'
    else
      'text_posts'
    end
  end

  def comment_attrs
    params.require(:comment).permit(:body)
  end
end
