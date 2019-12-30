class EntryMusic < ApplicationRecord

  belongs_to :session
  has_many   :entry_parts, dependent: :destroy
  belongs_to :user
end
