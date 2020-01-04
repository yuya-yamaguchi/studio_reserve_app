class Session < ApplicationRecord

  belongs_to :user
  belongs_to :user_reserve
  has_many   :entry_sessions, dependent: :destroy
  has_many   :entry_musics, dependent: :destroy
  has_many   :entry_parts, dependent: :destroy
  has_many   :users, through: :entry_sessions

  validates :title, presence: true
  validates :title, length: { maximum: 40, message: "40 文字以下で入力してください" }, allow_blank: true
  validates :studio_id,
    numericality: {greater_than_or_equal_to: 1,
                   less_than_or_equal_to:    4,
                   message: "選択してください"
                  }
  validates :date, presence: true
  validates :start_hour, presence: true
  validates :end_hour, presence: true
  validates :max_music, presence: true
  validates :entry_fee, presence: true

  def another_music_cnt
    cnt = self.entry_musics.where(status: 1).count
    self.max_music - cnt
  end

end