class MessagesController < ApplicationController
  
  protect_from_forgery except: [:create]
  before_action :sign_in_check, only: [:create]

  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = @chatroom.messages.new(message_params)
    
    if @message.save && @chatroom.update(updated_at: DateTime.now)
      respond_to do |format|
        format.html { redirect_to chatroom_path(@chatroom) }
        format.json { render json: { text: @message.text, created_at: @message.created_at.strftime("%Y/%m/%d %H:%M") }}
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id)
  end

  def sign_in_check
    unless user_signed_in?
      flash[:notice] = 'ログイン後（または会員登録後）を行ってください'
      redirect_to new_user_session_path
    end
  end
end
