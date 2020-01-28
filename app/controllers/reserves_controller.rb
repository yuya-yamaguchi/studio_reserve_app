class ReservesController < ApplicationController
  
  before_action :sign_in_check, only: [:update]

  def show
    @studio = Studio.find(params[:studio_id])
    @reserve = Reserve.find(params[:id])
    @one_week = @reserve.calc_one_week
  end

  def update
    begin
      ActiveRecord::Base.transaction do
        reserves = Reserve.new
        # スタジオ予約重複チェック
        if reserves.duplicate_chk2(params, current_user)
          flash[:alert] = '選択された時間帯はすでに予約されています。他の時間帯を指定してください'
          redirect_to studio_path(params[:studio_id])
          return
        end
        reserves = reserves.reserve_registar(set_reserve_params)
        
        user_reserve = UserReserve.new
        user_reserve.done_reserve(set_reserve_params)
        
        reserves.update(reserve_flg: 1, user_id: current_user.id)
        user_reserve.save!
      end
      flash[:notice] = '予約が完了しました'
      redirect_to user_reserves_path
    
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

  def duplicate
    reserves = Reserve.new
    reserved_result = reserves.duplicate_chk(params, current_user)
    respond_to do |format|
      format.json {render json: { reserved_result: reserved_result }}
    end
  end

  private
  def set_reserve_params
    params.permit(:studio_id,
                  :"date(1i)",
                  :"date(2i)",
                  :"date(3i)",
                  :start_hour,
                  :end_hour)
           .merge(user_id: current_user.id)
  end

  def sign_in_check
    unless user_signed_in?
      flash[:notice] = 'ログイン（または会員登録）を行ってください'
      redirect_to new_user_session_path
    end
  end
end
