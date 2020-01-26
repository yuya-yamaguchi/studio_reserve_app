class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :notice]

  def show
    begin
      @user = User.find(params[:id])
      # スタジオ予約状況の取得
      if @user.id == current_user&.id
        @user_reserves = @user.user_reserves.where('reserve_date >= ?', Date.today).order('reserve_date').order('start_hour').limit(3)
      end
      # 参加セッション一覧の取得(主催のセッションは除く)
      @sessions = @user.only_entry_sessions.where.not(user_id: current_user.id)
      # 主催セッション一覧の取得
      @organizer_sessions = @user.sessions
      # 投稿一覧の取得
      @posts = @user.posts
      # エントリー数のグラフデータを取得
      gon.data = @user.entry_part_praph
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

  def edit
    
  end

  def update
    begin
      @user.update!(user_params)
      redirect_to user_path(current_user.id)
    rescue ActiveRecord::RecordInvalid => e
      render :edit
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

  def notice
    begin
      @notices = current_user.notices.order("created_at DESC")
      @notices.each do |notice|
        notice.before_read_flg = notice.read_flg
      end

      update_notices = current_user.notices.where(read_flg: 0)
      update_notices.update(read_flg: 1)
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :first_name, :last_name, :tel_no, :email, :profile, :img)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
