class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.string     :title, null: false
      t.text       :contents, null: false
      t.timestamps
    end
  end
end
