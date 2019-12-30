class ReservesController < ApplicationController

  def show
    @studio = Studio.find(params[:studio_id])
    @reserve = Reserve.find(params[:id])
    @one_week = @reserve.calc_one_week
  end

  def update
    
    reserves = Reserve.where(studio_id: params[:studio_id])
                      .where(date: params[:date])
                      .where('? <= hour and hour < ?', params[:start_hour], params[:end_hour])
    
    user_reserve = UserReserve.new
    user_reserve.done_reserve(set_reserve_params)

    if reserves.update(reserve_flg: 1) && user_reserve.save
      redirect_to root_path
    else
      render :new
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
end
