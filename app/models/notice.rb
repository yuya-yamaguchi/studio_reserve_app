class Notice < ApplicationRecord

  belongs_to :user

  attr_accessor :before_read_flg

  def session_cancel_notice(session, user_id)
    self.user_id     = user_id
    self.title       = "【セッション中止のお知らせ】"
    self.contents    = "「#{session.title}」が中止されました"
    self.notice_type = 1
    self.read_flg    = 0
  end
end
