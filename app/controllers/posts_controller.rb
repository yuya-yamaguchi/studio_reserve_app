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
      flash[:notice] = '投稿が完了しました'
      redirect_to post_path(@post)
    else
      render action: :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = '編集が完了しました'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :contents).merge(user_id: current_user.id)
  end
end
