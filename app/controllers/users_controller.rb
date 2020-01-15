class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :notice]

  def show
    @user = User.find(params[:id])
    # スタジオ予約状況の取得
    if @user.id == current_user&.id
      @user_reserves = @user.user_reserves.where('reserve_date >= ?', Date.today).order('reserve_date').order('start_hour').limit(3)
    end
    # 参加セッション一覧の取得
    @sessions = @user.sessions
    # 投稿一覧の取得
    @posts = @user.posts
    # エントリー数のグラフデータを取得
    gon.data = @user.entry_part_praph
  end

  def edit
    
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def notice
    @notices = current_user.notices.order("created_at DESC")
    @notices.each do |notice|
      notice.before_read_flg = notice.read_flg
    end

    update_notices = current_user.notices.where(read_flg: 0)
    update_notices.update(read_flg: 1)
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :first_name, :last_name, :tel_no, :email, :profile, :img)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
