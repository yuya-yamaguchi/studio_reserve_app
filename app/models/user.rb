class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  mount_uploader :img, ImageUploader

  has_many :user_reserves
  has_many :posts
  has_many :entry_rooms
  has_many :chatrooms, through: :entry_rooms
  has_many :entry_sessions
  has_many :sessions
  has_many :only_entry_sessions, through: :entry_sessions, source: :session
  has_many :entry_parts
  has_many :notices

  validates :nickname, presence: true
  validates :nickname, length: { maximum: 20, message: "は20文字以下で入力してください" }, allow_blank: true
  validates :last_name, presence: true
  validates :last_name, length: { maximum: 20, message: "は20文字以下で入力してください" }, allow_blank: true
  validates :first_name, presence: true
  validates :first_name, length: { maximum: 20, message: "は20文字以下で入力してください" }, allow_blank: true
  validates :tel_no, format: {with:/\A\d{9,11}\z/}, allow_blank: true
  
  def entry_part_praph
    praph_data = []
    praph_data << self.entry_parts.where(part_no: 1).count
    praph_data << self.entry_parts.where(part_no: 2).count
    praph_data << self.entry_parts.where(part_no: [3, 4]).count
    praph_data << self.entry_parts.where(part_no: 5).count
    praph_data << self.entry_parts.where(part_no: 6).count
    praph_data << self.entry_parts.where(part_no: 7).count
  end

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    user = User.find_by(email: auth.info.email)
    # 会員登録済
    if user.present?
      sns = SnsCredential.create(
        user_id:  user.id,
        provider: auth.provider,
        uid:      uid,
        token:    auth.credentials.token
      )
    # 会員登録未
    else
      user = set_user(auth)
      sns = SnsCredential.create(
        user_id:  user.id,
        provider: auth.provider,
        uid:      uid,
        token:    auth.credentials.token
      )
    end
    # hashでsnsのidを設定
    return { user: user , sns_id: sns.id }
  end

  def self.set_user(auth)
    User.create(
      last_name:  auth.info.last_name,
      first_name: auth.info.first_name,
      nickname:   auth.info.name,
      email:      auth.info.email,
      img:        auth.info.image,
      password:   Devise.friendly_token[0,20]
    )
  end
end
