class AddYoutubeToEntryMusics < ActiveRecord::Migration[5.2]
  def change
    add_column :entry_musics, :youtube_url, :text, null: true
    add_column :entry_musics, :youtube_url_embed, :text, null: true
  end
end
