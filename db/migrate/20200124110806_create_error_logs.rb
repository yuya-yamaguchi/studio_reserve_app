class CreateErrorLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :error_logs do |t|
      t.string     :controller
      t.string     :action
      t.string     :ip_address
      t.text       :message
      t.text       :parameters
      t.timestamps
    end
  end
end
