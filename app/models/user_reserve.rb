class UserReserve < ApplicationRecord

  belongs_to :user
  belongs_to :studio
  has_one    :session

  def done_reserve(params)
    # 料金計算
    studio = Studio.find(params[:studio_id])
    use_time = params[:end_hour].to_i - params[:start_hour].to_i
    payment_fee = studio.fee * use_time
    
    # 日付設定
    reserve_date = Date.new(
      params["date(1i)"].to_i,
      params["date(2i)"].to_i,
      params["date(3i)"].to_i
    )

    self.user_id      = params[:user_id]
    self.studio_id    = params[:studio_id]
    self.reserve_date = reserve_date
    self.start_hour   = params[:start_hour]
    self.end_hour     = params[:end_hour]
    self.payment_fee  = payment_fee
  end

end
