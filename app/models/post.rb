class Post < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :contents, presence: true
end
