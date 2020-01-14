class Post < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :contents, presence: true

  enum post_type: {
    "---":              0,
    "バンドメンバー募集":  1,
    "バンド参加希望":      2,
    "その他":            99
  }, _prefix: true

  def self.search(search_params)
    results = Post.all
    results = results.where('title LIKE(?)', "%#{search_params[:keyword]}%")
    results
  end
end
