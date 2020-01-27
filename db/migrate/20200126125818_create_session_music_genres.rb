class CreateSessionMusicGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :session_music_genres do |t|
      t.references :session, null: false
      t.references :music_genre, null: false
      t.timestamps
    end
  end
end
