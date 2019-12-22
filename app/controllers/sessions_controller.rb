class SessionsController < ApplicationController

  def index
    @sessions = Session.all
  end

  def new
    @session = Session.new
  end

  def confirm
    session_params = set_session_params
    set_session(session_params)
  end

  def create
    studio = Studio.find(session[:studio_id])
    # reserveの設定
    reserves = Reserve.where(studio_id: session[:studio_id])
                      .where(date: session[:date])
                      .where('? <= hour and hour < ?', session[:start_hour], session[:end_hour])
    # user_reserveの設定
    user_reserve = UserReserve.new
    user_reserve.done_reserve(session, current_user.id, studio.fee)
    user_reserve.save
    # sessionの設定
    session_m = Session.new
    session_m.done_session(session, current_user.id, user_reserve.id)
    
    if reserves.update(reserve_flg: 1) && session_m.save
      redirect_to sessions_path
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
  end

  def set_session(session_params)
    date = Date.new(
      session_params[:"date(1i)"].to_i,
      session_params[:"date(2i)"].to_i,
      session_params[:"date(3i)"].to_i
    )
    session[:title]      = session_params[:title]
    session[:explain]    = session_params[:explain]
    session[:studio_id]  = session_params[:studio_id]
    session[:date]       = date
    session[:start_hour] = session_params[:start_hour]
    session[:end_hour]   = session_params[:end_hour]
    session[:max_music]  = session_params[:max_music]
    session[:entry_fee]  = session_params[:entry_fee]
  end
end
