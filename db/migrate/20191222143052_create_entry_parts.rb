class CreateEntryParts < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_parts do |t|
      t.references :entry_music, null: false
      t.references :user, null: true
      t.integer    :part_no, null: false
      t.string     :part_name, null: false
      t.integer    :apply_status, null: false, default: 0
      t.timestamps
    end
  end
end
