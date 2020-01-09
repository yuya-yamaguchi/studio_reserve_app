class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :img, :string, null: true
  end

  def down
    change_column :users, :img, :string, null: false
  end
end
