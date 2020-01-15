class EntrySessionsController < ApplicationController

  def create
    entry_session = EntrySession.new(session_id: params[:music_session_id],
                                     user_id: current_user.id)
    if entry_session.save
      redirect_to music_session_path(params[:music_session_id])
    else
      render music_session_path(params[:music_session_id])
    end
  end

  def destroy
    entry_session = current_user.entry_sessions.find_by(session_id: params[:music_session_id])
    entry_parts = current_user.entry_parts.where(session_id: params[:music_session_id])
    
    if entry_session.destroy && entry_parts.update(user_id: nil)
       redirect_to music_session_path(params[:music_session_id])
    end
  end
end
