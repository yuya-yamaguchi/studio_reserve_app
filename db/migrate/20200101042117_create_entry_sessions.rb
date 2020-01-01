class CreateEntrySessions < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_sessions do |t|
      t.references :session, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
