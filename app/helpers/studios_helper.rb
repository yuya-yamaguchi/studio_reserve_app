module StudiosHelper
  def comma_to_jpy(fee)
    "¥#{fee.to_s(:delimited, delimiter: ',')}"
  end
end
