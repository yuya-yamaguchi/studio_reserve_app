class CreateReserves < ActiveRecord::Migration[5.2]
  def change
    create_table :reserves do |t|
      t.references :studio, null: false
      t.date       :date, null: false
      t.integer    :hour, null: false
      t.integer    :reserve_flg, null: false, default: 0
      t.timestamps
    end
  end
end
