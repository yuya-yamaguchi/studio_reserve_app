class SessionsController < ApplicationController

  before_action :sign_in_check, only: [:new, :edit, :create, :update]

  def index
    @sessions = Session.where("date >= ?", Date.today).order(date: "DESC")
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
    @session_url = "/sessions/#{@session.id}"
  end

  def update
    @session = Session.find(params[:id])
    user_reserve_rm = @session.user_reserve
    # スタジオ予約取消
    # reserveのupdate(1 → 0)
    reserves_rm = Reserve.new
    reserves_rm = reserves_rm.reserve_cancel(user_reserve_rm)
    # user_reserveのdestroy
    user_reserve_rm.destroy!
    reserves_rm.update!(reserve_flg: 0, user_id: nil)
    
    # スタジオ再予約
    session_params = set_session_params
    # reserveのupdate(0 → 1)
    reserves_up = Reserve.new
    reserves_up = reserves_up.reserve_registar(session_params)
    reserves_up.update(reserve_flg: 1, user_id: current_user.id)
    # user_reserveのcreate
    user_reserve_up = UserReserve.new
    user_reserve_up.done_reserve(session_params)
    user_reserve_up.save

    session_params = session_params.merge(user_reserve_id: user_reserve_up.id)
    # sessionsのuser_reserve_idを変更
    if @session.update(session_params)
      flash[:notice] = 'セッションの変更が完了しました'
      redirect_to music_session_path(@session)
    end
  end

  def create
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
    session_m = Session.new(session_params)
    
    entry_sessions = session_m.entry_sessions.build(user_id: current_user.id)

    if reserves.update(reserve_flg: 1, user_id: current_user.id) && session_m.save && entry_sessions.save
      flash[:notice] = 'セッションの登録が完了しました'
      redirect_to music_session_path(session_m)
    end
  end

  def destroy
    @session = Session.find(params[:id])
    user_reserve_rm = @session.user_reserve
    # スタジオ予約取消
    # reserveのupdate(1 → 0)
    reserves_rm = Reserve.new
    reserves_rm = reserves_rm.reserve_cancel(user_reserve_rm)
    reserves_rm.update(reserve_flg: 0, user_id: nil)

    # セッション参加者にお知らせを作成
    @session.users.each do |entry_user|
      notice = Notice.new
      notice.session_cancel_notice(@session, entry_user.id)
      notice.save
    end
    # user_reserveのdestroy
    user_reserve_rm.destroy
    if @session.destroy
      flash[:notice] = 'セッションの取消が完了しました'
      redirect_to music_sessions_path
    end
  end

  def search
    @sessions = Session.search(search_params)
    render template: 'sessions/index'
  
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
                  :img)
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
