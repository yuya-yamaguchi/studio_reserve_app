class ChatroomsController < ApplicationController

  def show
    @chatroom = Chatroom.find(params[:id])
    # 空のメッセージを作成
    @message = Message.new
    @messages = @chatroom.messages

    @receiver = @chatroom.get_receiver(current_user)
    
    receiver_messages = @chatroom.messages.where.not(user_id: current_user.id).where(read_flg: 0)
    receiver_messages.update(read_flg: 1)
  end

  def room_judge
    entry_room = EntryRoom.new
    belong_room = entry_room.get_belong_room(params, current_user)
    if belong_room.empty?
      chatroom_params = {user_ids: [params[:user_id], current_user.id]}
      @chatroom = Chatroom.create(chatroom_params)
    else
      chatroom_id = belong_room.first[0]
      @chatroom = Chatroom.find(chatroom_id)
    end
    redirect_to chatroom_path(@chatroom)
  end
end
