class Session < ApplicationRecord

  belongs_to :user
  belongs_to :user_reserve
  has_many   :entry_sessions, dependent: :destroy
  has_many   :entry_musics, dependent: :destroy
  has_many   :entry_parts, dependent: :destroy
  has_many   :users, through: :entry_sessions

  def another_music_cnt
    cnt = self.entry_musics.where(status: 1).count
    self.max_music - cnt
  end

end