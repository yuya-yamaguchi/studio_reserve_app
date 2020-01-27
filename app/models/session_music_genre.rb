class SessionMusicGenre < ApplicationRecord

  belongs_to :session
  belongs_to :music_genre

end
