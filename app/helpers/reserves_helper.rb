module ReservesHelper

  def day_of_week(day)
    return "日" if day == 0
    return "月" if day == 1
    return "火" if day == 2
    return "水" if day == 3
    return "木" if day == 4
    return "金" if day == 5
    return "土" if day == 6
  end

end
