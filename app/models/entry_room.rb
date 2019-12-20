class EntryRoom < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  def get_belong_room(params, current_user)
    EntryRoom.where('user_id in (?, ?)', params[:user_id], current_user.id)
             .group(:chatroom_id)
             .having('count(*) > ?', 1).count
  end
end
