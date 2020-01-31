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
    post_type_num = post_type_string2num(search_params[:post_type])
    results = Post.all
    results = results.where('post_type = ?', post_type_num) if post_type_num != 0
    results = results.where('title LIKE(?)', "%#{search_params[:keyword]}%")
    results = results.order('created_at DESC')
    results
  end

  private
  def self.post_type_string2num(post_type_string)
    case post_type_string
    when "バンドメンバー募集"
      return 1
    when "バンド参加希望"
      return 2
    when "その他"
      return 99
    else
      return 0
    end
  end
end
