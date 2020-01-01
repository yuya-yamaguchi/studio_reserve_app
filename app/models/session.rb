class Session < ApplicationRecord

  belongs_to :user
  belongs_to :user_reserve
  has_many   :entry_sessions, dependent: :destroy
  has_many   :entry_musics, dependent: :destroy
  has_many   :entry_parts, dependent: :destroy

end