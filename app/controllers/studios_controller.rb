class StudiosController < ApplicationController

  def show
    @studio = Studio.find(params[:id])
    reserve = Reserve.new
    @one_week = reserve.calc_one_week
    @studio_reserves = reserve.reserve_list_set(params[:id])
  end

end
