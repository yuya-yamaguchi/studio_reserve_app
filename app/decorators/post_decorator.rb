# frozen_string_literal: true

module PostDecorator

  def contents_cut
    if contents.length > 100
      return contents[0..100] + "..."
    else
      return contents
    end
  end

end
