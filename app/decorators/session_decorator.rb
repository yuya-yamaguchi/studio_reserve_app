# frozen_string_literal: true

module SessionDecorator

  def hold_datetime
    date.strftime("%Y年%-m月%-d日 ") + start_hour.to_s + "時〜" + end_hour.to_s + "時"
  end

end
