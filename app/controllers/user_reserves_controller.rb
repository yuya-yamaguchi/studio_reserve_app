class UserReservesController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @user_reserves = @user.user_reserves.order('reserve_date DESC').order('start_hour DESC')
  end

  def destroy
    user_reserve = UserReserve.find(params[:id])
    reserve = Reserve.new
    reserve = reserve.reserve_cancel(user_reserve)
    if reserve.update(reserve_flg: 0) && user_reserve.destroy
      flash[:notice] = '予約取消が完了しました'
      redirect_to user_reserves_path
    else
      render :reserve
    end
  end

end
