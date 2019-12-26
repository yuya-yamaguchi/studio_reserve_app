class Session < ApplicationRecord

  belongs_to :user
  belongs_to :user_reserve
  has_many   :entry_musics

  def done_session(session, user_id, user_reserve_id)
    self.user_id          = user_id
    self.studio_id        = session[:studio_id]
    self.user_reserve_id  = user_reserve_id
    self.title            = session[:title]
    self.explain          = session[:explain]
    self.date             = session[:date]
    self.start_hour       = session[:start_hour]
    self.end_hour         = session[:end_hour]
    self.max_music        = session[:max_music]
    self.entry_fee        = session[:entry_fee]
  end
end