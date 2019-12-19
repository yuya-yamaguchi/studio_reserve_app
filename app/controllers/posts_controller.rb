class PostsController < ApplicationController

  def index
    @posts = Post.all
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
    if Post.create(post_params)
      redirect_to posts_path
    else
      render :new
    end
  end

  def update
    if Post.update(post_params)
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
