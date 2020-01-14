class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order("updated_at DESC")
  end

  def new
    @post = Post.new
  end

  def show
    
  end

  def edit
    
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
    
    if @post.update(post_params)
      flash[:notice] = '編集が完了しました'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    
    if @post.destroy
      flash[:notice] = '投稿を削除しました'
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def search
    @posts = Post.search(search_params)
    render template: 'posts/index'
  end

  private
  def post_params
    params.require(:post).permit(:title, :contents, :post_type).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def search_params
    params.permit(:post_type, :keyword)
  end
end
