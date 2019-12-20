class Chatroom < ApplicationRecord
  has_many :entry_rooms
  has_many :users, through: :entry_rooms
  has_many :messages

  attr_accessor :resever, :unread_cnt

  def get_receiver(current_user)
    chatroom_users = self.users
    chatroom_users.each do |chatroom_user|
      if chatroom_user.id != current_user.id
        return chatroom_user
      end
    end
  end

end
