class SessionsController < ApplicationController

  before_action :sign_in_check, only: [:new, :edit, :create, :update]

  def index
    @sessions = Session.where("date >= ?", Date.today).order(:date)
  end

  def show
    @session = Session.find(params[:id])
    @entry_music = EntryMusic.new
    @entry_musics = @session.entry_musics
    @entry_sessions = @session.entry_sessions
    @current_user_entry = @session.current_user_entry_judge(current_user)
  end

  def new
    @session = Session.new
    @session_url = "/sessions"
  end

  def edit
    @session = Session.find(params[:id])
    # セッション情報変更チェック
    chk_result = @session.info_change_chk(current_user)
    if chk_result == false
      flash[:alert] = @session.error_message
      redirect_to music_session_path(params[:id])
      return
    end
    @session_url = "/sessions/#{@session.id}"
  end

  def update
    begin
      ActiveRecord::Base.transaction do
        @session = Session.find(params[:id])
        user_reserve_rm = @session.user_reserve
        
        # スタジオ予約取消
        # reserveのupdate(1:予約済 → 0:予約未済)
        reserves_rm = Reserve.new
        reserves_rm = reserves_rm.reserve_cancel(user_reserve_rm)
        # user_reserveのdestroy(現在の予約取消)
        user_reserve_rm.destroy!
        reserves_rm.update(reserve_flg: 0, user_id: nil)

        # スタジオ再予約
        session_params = set_session_params
        # reserveのupdate(0:予約未済 → 1:予約済)
        reserves_up = Reserve.new
        reserves_up = reserves_up.reserve_registar(session_params)
        reserves_up.update(reserve_flg: 1, user_id: current_user.id)
        # user_reserveのcreate(再予約)
        user_reserve_up = UserReserve.new
        user_reserve_up.done_reserve(session_params)
        user_reserve_up.save!

        session_params = session_params.merge(user_reserve_id: user_reserve_up.id)
        # sessionsのuser_reserve_idを変更
        @session.update(session_params)
        flash[:notice] = 'セッションの変更が完了しました'
        redirect_to music_session_path(@session)
      end
    rescue ActiveRecord::RecordInvalid => e
      render :edit
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        session_params = set_session_params

        # reserveの設定
        reserves = Reserve.new
        reserves = reserves.reserve_registar(set_session_params)

        # user_reserveの設定
        @user_reserve = UserReserve.new
        @user_reserve.done_reserve(session_params)
        @user_reserve.save
        # sessionの設定
        session_params = session_params.merge(user_reserve_id: @user_reserve.id)
        @session_m = Session.new(session_params)

        entry_sessions = @session_m.entry_sessions.build(user_id: current_user.id)

        reserves.update(reserve_flg: 1, user_id: current_user.id)
        @session_m.save!
        entry_sessions.save!
      end
      flash[:notice] = 'セッションの登録が完了しました'
      redirect_to music_session_path(@session_m)
    rescue ActiveRecord::RecordInvalid => e
      render :new
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

  def destroy
    error_message = nil
    begin
      ActiveRecord::Base.transaction do
        @session = Session.find(params[:id])
        user_reserve_rm = @session.user_reserve
        # セッション中止可否チェック
        chk_result = @session.cancel_chk(current_user)
        if chk_result == false
          flash[:alert] = @session.error_message
          redirect_to music_session_path(params[:id])
          return
        end
        # スタジオ予約取消
        # reserveのupdate(1:予約済 → 0:予約未済)
        reserves_rm = Reserve.new
        reserves_rm = reserves_rm.reserve_cancel(user_reserve_rm)
        reserves_rm.update(reserve_flg: 0, user_id: nil)

        # セッション参加者に中止のお知らせを作成
        @session.users.each do |entry_user|
          notice = Notice.new
          notice.session_cancel_notice(@session, entry_user.id)
          notice.save!
        end
        # スタジオの予約を削除
        user_reserve_rm.destroy!
        # セッションを削除
        @session.destroy!
      end
      flash[:notice] = 'セッションの取消が完了しました'
      redirect_to music_sessions_path
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

  def search
    begin
      @sessions = Session.search(search_params)
      render template: 'sessions/index'
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

  private
  def set_session_params
    params.require(:session)
          .permit(:title,
                  :explain,
                  :studio_id,
                  :"date(1i)",
                  :"date(2i)",
                  :"date(3i)",
                  :start_hour,
                  :end_hour,
                  :max_music,
                  :entry_fee,
                  :img,
                  { :music_genre_ids => [] })
           .merge(user_id: current_user.id)
  end

  def search_params
    params.permit(:date_select, :start_date, :end_date, :keyword)
  end

  def sign_in_check
    unless user_signed_in?
      flash[:notice] = 'ログイン（または会員登録）を行ってください'
      redirect_to new_user_session_path
    end
  end
end
