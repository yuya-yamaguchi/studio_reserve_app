class UserReserve < ApplicationRecord

  belongs_to :user
  belongs_to :studio
  has_one    :sessions

  def done_reserve(params, user_id, studio_fee)
    use_time = params[:end_hour].to_i - params[:start_hour].to_i
    payment_fee = studio_fee * use_time

    self.user_id      = user_id
    self.studio_id    = params[:studio_id]
    self.reserve_date = params[:date]
    self.start_hour   = params[:start_hour]
    self.end_hour     = params[:end_hour]
    self.payment_fee  = payment_fee
  end

end
