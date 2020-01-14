class Session < ApplicationRecord

  mount_uploader :img, ImageUploader

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
    results
  end

end