class AddImgToSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :img, :string
  end
end
