class CreateNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :notices do |t|
      t.references :user, null: false
      t.string     :title, null: false
      t.text       :contents, null: false
      t.integer    :notice_type, null: false
      t.integer    :read_flg, null: false, default: 0
      t.timestamps
    end
  end
end
