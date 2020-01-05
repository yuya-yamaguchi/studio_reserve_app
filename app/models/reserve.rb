class Reserve < ApplicationRecord

  def calc_one_week
    # 本日から1週間分の日付を算出
    today = Date.today
    @one_week = []
    7.times { |i| @one_week << today + i.day}
    return @one_week
  end

  def reserve_list_set(studio_id)
    # 時間の開始・終了時間を取得
    set_max_min_hour(studio_id)
    # インクリメント用変数
    hour = @min_hour
    # 予約表設定処理
    studio_reserves = []
    while hour <= @max_hour do
      # 各日の時間単位で配列に設定
      studio_reserves.push(Reserve.where(studio_id: studio_id)
                                  .where(hour: hour)
                                  .where('date between ? and ?', @one_week[0], @one_week[6])
                                  .order(:date))
      hour += 1
    end
    return studio_reserves
  end

  def start_hour_range(studio_id)
    # 時間の開始・終了時間を取得
    set_max_min_hour(studio_id)
    @start_range = [*@min_hour..@max_hour]
  end

  def end_hour_range(studio_id)
    # 時間の開始・終了時間を取得
    set_max_min_hour(studio_id)
    @end_range = [*@min_hour+1..@max_hour+1]
  end

  def reserve_cancel(user_reserve)
    
    reserve = Reserve.where(studio_id: user_reserve.studio_id)
                     .where(date:      user_reserve.reserve_date)
                     .where('? <= hour and hour < ?', user_reserve.start_hour, user_reserve.end_hour)
    return reserve
  end

  def reserve_registar(params)
    if params["date(1i)"].present? && params["date(2i)"].present? && params["date(3i)"].present?
      hold_date = Date.new(
        params["date(1i)"].to_i,
        params["date(2i)"].to_i,
        params["date(3i)"].to_i
      )
      reserves = Reserve.where(studio_id: params[:studio_id])
                        .where(date: hold_date)
                        .where('? <= hour and hour < ?', params[:start_hour], params[:end_hour])
      return reserves
    end
  end

  def duplicate_chk(params)
    date = Date.new(
      params[:date_y].to_i,
      params[:date_m].to_i,
      params[:date_d].to_i
    )
    reserved_cnt = Reserve.where(studio_id: params[:studio_id])
                          .where(date: date)
                          .where('? <= hour and hour < ?', params[:start_hour], params[:end_hour])
                          .where(reserve_flg: 1)
                          .count
    if (reserved_cnt > 0)
      return true
    else
      return false
    end
  end

  private
  def set_max_min_hour(studio_id)
    # 時間の最大値を取得
    @max_hour = Reserve.where(studio_id: studio_id).maximum(:hour)
    # 時間の最小値を取得
    @min_hour = Reserve.where(studio_id: studio_id).minimum(:hour)
  end
end
