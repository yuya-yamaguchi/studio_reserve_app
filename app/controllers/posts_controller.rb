class PostsController < ApplicationController

  def index
    @posts = Post.all.order("updated_at DESC")
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render action: :new
    end
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :contents).merge(user_id: current_user.id)
  end
end
