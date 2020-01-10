class AddSizeToStudios < ActiveRecord::Migration[5.2]
  def change
    add_column :studios, :size, :float
    add_column :studios, :explain, :text
  end
end
