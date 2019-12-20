class CreateEntryRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_rooms do |t|
      t.references :user, null: false
      t.references :chatroom, null: false
      t.timestamps
    end
  end
end
