class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :img, ImageUploader

  validates :nickname, presence: true
  validates :nickname, length: { maximum: 20, message: "は20文字以下で入力してください" }, allow_blank: true
  validates :last_name, presence: true
  validates :last_name, length: { maximum: 20, message: "は20文字以下で入力してください" }, allow_blank: true
  validates :first_name, presence: true
  validates :first_name, length: { maximum: 20, message: "は20文字以下で入力してください" }, allow_blank: true
  validates :tel_no, format: {with:/\A\d{9,11}\z/}, allow_blank: true
  
  has_many :user_reserves
  has_many :posts
  has_many :entry_rooms
  has_many :chatrooms, through: :entry_rooms
  has_many :entry_sessions
  has_many :sessions
  has_many :only_entry_sessions, through: :entry_sessions, source: :session
  has_many :entry_parts
  has_many :notices

  def entry_part_praph
    praph_data = []
    praph_data << self.entry_parts.where(part_no: 1).count
    praph_data << self.entry_parts.where(part_no: 2).count
    praph_data << self.entry_parts.where(part_no: [3, 4]).count
    praph_data << self.entry_parts.where(part_no: 5).count
    praph_data << self.entry_parts.where(part_no: 6).count
    praph_data << self.entry_parts.where(part_no: 7).count
  end
end
