class AddSessionIdToEntryParts < ActiveRecord::Migration[5.2]
  def change
    add_reference :entry_parts, :session, foreign_key: true
  end
end
