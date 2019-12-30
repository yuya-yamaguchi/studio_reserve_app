class CreateEntryMusics < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_musics do |t|
      t.references :user, null: false
      t.references :session, null: false
      t.string     :music_name, null: false
      t.string     :artist_name, null: false
      t.integer    :status, null: false, default: 0
      t.timestamps
    end
  end
end
