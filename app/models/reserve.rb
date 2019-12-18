class Reserve < ApplicationRecord

  def calc_one_week
    # 本日から1週間分の日付を算出
    today = Date.today
    @one_week = []
    7.times { |i| @one_week << today + i.day}
    return @one_week
  end

  def reserve_list_set(studio_id)
    # 時間の最大値を取得
    max_hour = Reserve.where(studio_id: studio_id).maximum(:hour)
    # 時間の最小値を取得
    min_hour = Reserve.where(studio_id: studio_id).minimum(:hour)
    # インクリメント用変数
    hour = min_hour
    
    # 予約表設定処理
    studio_reserves = []
    while hour <= max_hour do
      # 各日の時間単位で配列に設定
      studio_reserves.push(Reserve.where(studio_id: studio_id)
                                  .where(hour: hour)
                                  .where('date between ? and ?', @one_week[0], @one_week[6])
                                  .order(:date))
      hour += 1
    end
    return studio_reserves
  end

end
