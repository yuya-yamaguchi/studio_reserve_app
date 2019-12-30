class EntryMusic < ApplicationRecord

  belongs_to :session
  has_many   :entry_parts
  belongs_to :user
end
