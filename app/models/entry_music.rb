class EntryMusic < ApplicationRecord

  belongs_to :session
  has_many   :entry_parts, dependent: :destroy
  belongs_to :user

  def edit_youtube_url
    edit_url = nil

    if youtube_url.match("https://www.youtube.com/watch")
      edit_url = youtube_url.gsub("https://www.youtube.com/watch?v=", "https://www.youtube.com/embed/")
      edit_url = edit_url.sub(/&.+/,'')
    elsif youtube_url.match("https://youtu.be")
      edit_url = youtube_url.gsub("https://youtu.be", "https://www.youtube.com/embed")
    end
    self.youtube_url_embed = edit_url
  end
end
