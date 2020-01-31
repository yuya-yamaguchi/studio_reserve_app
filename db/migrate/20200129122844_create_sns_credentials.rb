class CreateSnsCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :sns_credentials do |t|
      t.references :user, null: false
      t.string     :provider
      t.string     :uid
      t.string     :token
      t.timestamps
    end
  end
end
