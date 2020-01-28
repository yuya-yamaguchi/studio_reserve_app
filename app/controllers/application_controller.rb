class ApplicationController < ActionController::Base
  include ErrorHandlers
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :header_info

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name, :tel_no])
  end

  def header_info
    # スタジオ情報の取得
    @studio_lists = Studio.all
    if user_signed_in?
      # 未読メッセージの件数取得
      @unread_message_cnt = 0
      chatrooms = current_user.chatrooms.order("updated_at DESC")
      chatrooms.each do |chatroom|

        if chatroom.messages.present?
          resever = chatroom.get_receiver(current_user)
          chatroom.resever = resever.nickname

          unread_message_cnt = chatroom.messages.where(user_id: resever.id)
                                        .where(read_flg: 0).count
          @unread_message_cnt += unread_message_cnt
        end
      end
      # 未読お知らせの件数取得
      @unread_notice_cnt = current_user.notices.where(read_flg: 0).count
    end
  end
end
