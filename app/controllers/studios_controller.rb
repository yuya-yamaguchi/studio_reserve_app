class StudiosController < ApplicationController

  def show
    begin
      @studio = Studio.find(params[:id])
      reserve = Reserve.new
      @one_week = reserve.calc_one_week
      @studio_reserves = reserve.reserve_list_set(params[:id])
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

end
