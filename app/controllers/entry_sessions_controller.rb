class EntrySessionsController < ApplicationController

  def create
    entry_session = EntrySession.new(session_id: params[:music_session_id],
                                     user_id: current_user.id)
    entry_session.save!
    redirect_to music_session_path(params[:music_session_id])
  end

  def destroy
    begin
      ActiveRecord::Base.transaction do
        entry_session = current_user.entry_sessions.find_by(session_id: params[:music_session_id])
        entry_parts = current_user.entry_parts.where(session_id: params[:music_session_id])

        entry_session.destroy!
        entry_parts.update(user_id: nil)
      end
      redirect_to music_session_path(params[:music_session_id])
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end
end
