class UserReservesController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @user_reserves = @user.user_reserves.order('reserve_date DESC').order('start_hour DESC')
  end

  def destroy
    begin
      ActiveRecord::Base.transaction do
        user_reserve = UserReserve.find(params[:id])
        reserve = Reserve.new
        reserve = reserve.reserve_cancel(user_reserve)
        reserve.update(reserve_flg: 0, user_id: nil)
        user_reserve.destroy!
      end
      flash[:notice] = '予約取消が完了しました'
      redirect_to user_reserves_path
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

end
