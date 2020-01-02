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
end
