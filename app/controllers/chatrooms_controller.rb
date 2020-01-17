class ChatroomsController < ApplicationController

  before_action :sign_in_check

  def index
    @user = current_user
    @chatrooms = current_user.chatrooms.order("updated_at DESC")
    
    @chatrooms.each do |chatroom|
      
      if chatroom.messages.present?
        resever = chatroom.get_receiver(current_user)
        chatroom.resever = resever.nickname

        unread_cnt = chatroom.messages.where(user_id: resever.id)
                                      .where(read_flg: 0).count
        chatroom.unread_cnt = unread_cnt
      end
    end
  end

  def show
    @user = current_user
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

  private
  def sign_in_check
    unless user_signed_in?
      flash[:notice] = 'ログイン後（または会員登録後）を行ってください'
      redirect_to new_user_session_path
    end
  end
end
