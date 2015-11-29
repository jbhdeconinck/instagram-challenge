class PostsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show] #brings user to login if unauthenticated

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
    redirect_to '/posts'
  end

  def edit
    @post = Post.find(params[:id])
    
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash[:notice] = 'Post updated successfully'
    redirect_to '/posts'
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      flash[:notice] = 'Post cannot be deleted'
      redirect_to '/posts'
    else
      @post.destroy
      flash[:notice] = 'Post deleted successfully'
      redirect_to '/posts'
    end
  end

  def post_params
    params.require(:post).permit(:name, :image, :description)
  end

end
