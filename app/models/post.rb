class Post < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :contents, presence: true

  def self.search(search_params)
    results = Post.all
    results = results.where('title LIKE(?)', "%#{search_params[:keyword]}%")
    results
  end
end
