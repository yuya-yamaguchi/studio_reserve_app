class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user, null: false
      t.references :chatroom, null: false
      t.text       :text
      t.integer    :read_flg, default: 0, null: false
      t.timestamps
    end
  end
end
