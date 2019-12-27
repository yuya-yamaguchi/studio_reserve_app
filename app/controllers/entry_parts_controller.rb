class EntryPartsController < ApplicationController
  protect_from_forgery :except => [:update]
  def update
    entry_music = EntryMusic.find(params[:entry_music_id])
    entry_part = EntryPart.find(params[:id])
    if entry_part.update(user_id: current_user.id)
      part_cnt = entry_music.entry_parts.where(apply_status: 1)
                                        .where(user_id: nil).count
      if part_cnt == 0
        entry_music.update(status: 1)
      end
      respond_to do |format|
        format.html { redirect_to session_path(params[:session_id]) }
        format.json { render json: { user_id: entry_part.user_id, user_name: entry_part.user.nickname } }
      end
    end
  end
end
