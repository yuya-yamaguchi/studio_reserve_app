# frozen_string_literal: true

module PostDecorator

  def contents_cut
    if contents.length > 100
      return contents[0..100] + "..."
    else
      return contents
    end
  end

  def post_type_icon
    case post_type
    when "バンドメンバー募集"
      return "募"
    when "バンド参加希望"
      return "参"
    else
      return "他"
    end
  end

end
