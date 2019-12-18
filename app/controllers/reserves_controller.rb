class ReservesController < ApplicationController

  def show
    @studio = Studio.find(params[:studio_id])
    @reserve = Reserve.find(params[:id])
    @one_week = @reserve.calc_one_week
  end
end
