class CreateStudios < ActiveRecord::Migration[5.2]
  def change
    create_table :studios do |t|
      t.string     :name, null: false
      t.integer    :fee, null: false, default: 0
      t.string     :guitar_amp
      t.string     :bass_amp
      t.string     :drums
      t.string     :keybords
      t.timestamps
    end
  end
end
