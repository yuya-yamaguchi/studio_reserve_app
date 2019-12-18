class UserReservesController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @user_reserves = @user.user_reserves.order('reserve_date DESC').order('start_hour DESC')
  end

  def destroy
    user_reserve = UserReserve.find(params[:id])
    reserve = Reserve.where(studio_id: user_reserve.studio_id)
                     .where(date:      user_reserve.reserve_date)
                     .where('? <= hour and hour < ?', user_reserve.start_hour, user_reserve.end_hour)
    if reserve.update(reserve_flg: 0) && user_reserve.destroy
      redirect_to user_reserves_path
    else
      render :reserve
    end
  end

end
