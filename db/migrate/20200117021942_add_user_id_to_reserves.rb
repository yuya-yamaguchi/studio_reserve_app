class AddUserIdToReserves < ActiveRecord::Migration[5.2]
  def change
    add_reference :reserves, :user, foreign_key: true, null: true
  end
end
