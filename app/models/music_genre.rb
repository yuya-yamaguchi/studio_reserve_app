class MusicGenre < ApplicationRecord

  has_many   :session_music_genres
  has_many   :sessions, through: :session_music_genres

end
