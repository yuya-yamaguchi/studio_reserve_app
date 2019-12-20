class MessagesController < ApplicationController
  protect_from_forgery :except => [:create]
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = @chatroom.messages.new(message_params)
        
    if @message.save
      respond_to do |format|
        format.html { redirect_to chatroom_path(@chatroom) }
        format.json { render json: { text: @message.text }}
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id)
  end
end
