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
