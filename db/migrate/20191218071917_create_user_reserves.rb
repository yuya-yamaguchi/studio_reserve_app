class CreateUserReserves < ActiveRecord::Migration[5.2]
  def change
    create_table :user_reserves do |t|
      t.references :user, null: false
      t.references :studio, null: false
      t.date       :reserve_date, null: false
      t.integer    :start_hour, null: false
      t.integer    :end_hour, null: false
      t.integer    :payment_fee, null: false, default: 0
      t.timestamps
    end
  end
end
