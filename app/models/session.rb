class Session < ApplicationRecord

  mount_uploader :img, ImageUploader

  belongs_to :user
  belongs_to :user_reserve
  has_many   :entry_sessions, dependent: :destroy
  has_many   :entry_musics, dependent: :destroy
  has_many   :entry_parts, dependent: :destroy
  has_many   :users, through: :entry_sessions
  has_many   :session_music_genres
  has_many   :music_genres, through: :session_music_genres

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

  attr_accessor :error_message

  def another_music_cnt
    cnt = self.entry_musics.where(status: 1).count
    self.max_music - cnt
  end

  def current_user_entry_judge(current_user)
    if current_user.present?
      current_user_entry = self.entry_sessions.find_by(user_id: current_user.id)
    else
      return false
    end
  end

  def self.search(search_params)
    results = Session.all
    results = results.where('date between ? and ?', search_params[:start_date], search_params[:end_date]) if search_params[:date_select] == "1"
    results = results.where('title LIKE(?)', "%#{search_params[:keyword]}%")
    results = results.order('date DESC')
    results
  end

  def calc_remaining_days
    (date - Date.today).to_i
  end

  def cancel_chk(current_user)
    # 主催者チェック
    if current_user.id != self.user_id
      self.error_message = "主催者以外は中止できません"
      return false
    end
    # 日付チェック
    if date < Date.today
      self.error_message = "開催日を過ぎたセッションは中止できません"
      return false
    elsif date == Date.today
      self.error_message = "当日のセッションは中止できません"
      return false
    end
  end

  def info_change_chk(current_user)
    # 主催者チェック
    if current_user.id != self.user_id
      self.error_message = "主催者以外は変更できません"
      return false
    end
    # 日付チェック
    if date < Date.today
      self.error_message = "開催日を過ぎたセッションは変更できません"
      return false
    end
  end

end