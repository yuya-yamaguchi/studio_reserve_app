class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :img, ImageUploader

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :tel_no, presence: true
  
  has_many :user_reserves
  has_many :posts
  has_many :entry_rooms
  has_many :chatrooms, through: :entry_rooms
  has_many :entry_sessions
  has_many :sessions, through: :entry_sessions
  has_many :entry_parts
end
