class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.references :user, null: false
      t.references :studio, null: false
      t.references :user_reserve, null: false
      t.string     :title, null: false
      t.text       :explain, null: false
      t.date       :date, null: false
      t.integer    :start_hour, null: false
      t.integer    :end_hour, null: false
      t.integer    :max_music, null: false
      t.string     :entry_fee
      t.timestamps
    end
  end
end
