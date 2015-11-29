class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.build_comment comment_params, current_user

    if @comment.save
      redirect_to posts_path
    else
      if @comment.errors[:user]
        # Note: if you have correctly disabled the review button where appropriate,
        # this should never happen...
        redirect_to posts_path, alert: 'You have already commented on this post'
      else
        # Why would we render new again?  What else could cause an error?
        render :new
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:thoughts)
  end
end
