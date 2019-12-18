class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.references :user, null: false
      t.string     :title, null: false
      t.string     :contents, null: false
      t.timestamps
    end
  end
end
