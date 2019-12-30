# frozen_string_literal: true

module EntryMusicDecorator
  
  def complete_status
    if status == 0
      return "未成立"
    else
      return "成立"
    end
  end
end
