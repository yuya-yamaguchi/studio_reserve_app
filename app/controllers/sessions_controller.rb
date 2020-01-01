class SessionsController < ApplicationController

  def index
    @sessions = Session.all
  end

  def show
    @session = Session.find(params[:id])
    @entry_music = EntryMusic.new
    @entry_musics = @session.entry_musics
    @current_user_entry = @session.entry_sessions.find_by(user_id: current_user.id)
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
    reserves_rm.update(reserve_flg: 0)
    # user_reserveのdestroy
    user_reserve_rm.destroy
    
    # スタジオ再予約
    session_params = set_session_params
    # reserveのupdate(0 → 1)
    reserves_up = Reserve.new
    reserves_up = reserves_up.reserve_registar(session_params)
    reserves_up.update(reserve_flg: 1)
    # user_reserveのcreate
    user_reserve_up = UserReserve.new
    user_reserve_up.done_reserve(session_params)
    user_reserve_up.save

    session_params = session_params.merge(user_reserve_id: user_reserve_up.id)
    # sessionsのuser_reserve_idを変更
    if @session.update(session_params)
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
    
    if reserves.update(reserve_flg: 1) && session_m.save
      redirect_to music_sessions_path
    end
  end

  def destroy
    @session = Session.find(params[:id])
    user_reserve_rm = @session.user_reserve
    # スタジオ予約取消
    # reserveのupdate(1 → 0)
    reserves_rm = Reserve.new
    reserves_rm = reserves_rm.reserve_cancel(user_reserve_rm)
    reserves_rm.update(reserve_flg: 0)
    # user_reserveのdestroy
    user_reserve_rm.destroy
    if @session.destroy
      redirect_to music_sessions_path
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
                  :entry_fee)
           .merge(user_id: current_user.id)
  end
end
