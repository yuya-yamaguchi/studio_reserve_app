class ReservesController < ApplicationController
  
  before_action :sign_in_check, only: [:update]

  def show
    @studio = Studio.find(params[:studio_id])
    @reserve = Reserve.find(params[:id])
    @one_week = @reserve.calc_one_week
  end

  def update
    
    reserves = Reserve.new
    reserves = reserves.reserve_registar(set_reserve_params)
    
    user_reserve = UserReserve.new
    user_reserve.done_reserve(set_reserve_params)
    
    if reserves.update(reserve_flg: 1) && user_reserve.save
      redirect_to user_reserves_path
    else
      render :new
    end
  end

  def duplicate
    reserves = Reserve.new
    reserved_result = reserves.duplicate_chk(params)
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
      redirect_to new_user_session_path
    end
  end
end
