class EntryPartsController < ApplicationController
  protect_from_forgery :except => [:update]

  def update
    entry_music = EntryMusic.find(params[:entry_music_id])
    entry_part = EntryPart.find(params[:id])
    palyer_id = 0
    if params[:user_id].present?
      palyer_id = params[:user_id]
    else
      palyer_id = current_user.id
    end
    
    entry_session = EntrySession.where(user_id:    palyer_id)
                                .where(session_id: params[:music_session_id])
    if entry_session.empty?
      EntrySession.create(session_id: params[:music_session_id], user_id: palyer_id)
    end
    # パートの更新が成功した場合
    if entry_part.update(user_id: palyer_id)
      # エントリー曲の成立・不成立を判定し、更新
      entry_part.entry_music_establish

      respond_to do |format|
        format.html { redirect_to music_session_path(params[:music_session_id]) }
        format.json { render json: { session_id:     params[:music_session_id],
                                     entry_music_id: params[:entry_music_id],
                                     id:             params[:id],
                                     user_id:        entry_part.user_id,
                                     user_name:      entry_part.user.nickname } }
      end
    end
  end

  def cancel
    entry_part = EntryPart.find(params[:id])
    # パートの更新が成功した場合
    if entry_part.update(user_id: nil)
      # エントリー曲の成立・不成立を判定し、更新
      entry_part.entry_music_establish
    
      respond_to do |format|
        format.html { redirect_to music_session_path(params[:music_session_id]) }
        format.json { render json: { session_id:     params[:music_session_id],
                                     entry_music_id: params[:entry_music_id],
                                     id:             params[:id],
                                     apply_status: entry_part.apply_status } }
      end
    end
  end
end
