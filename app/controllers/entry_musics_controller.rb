class EntryMusicsController < ApplicationController

  def show
    @session = Session.find(params[:music_session_id])
    @current_user_entry = @session.current_user_entry_judge(current_user)
    @entry_music = EntryMusic.find(params[:id])
  end

  def create
    entry_music = EntryMusic.new(entry_music_params)
    entry_music.edit_youtube_url
    entry_music.save
    
    entry_part_params_array = entry_part_params.to_h.to_a
    entry_part_params_array.each_with_index do |param, cnt|
      entry_part = EntryPart.new
      entry_part.set_default_part(params[:music_session_id], entry_music.id, param, cnt)
      entry_part.save
    end

    redirect_to music_session_path(params[:music_session_id])
  end

  def destroy
    if EntryMusic.destroy(params[:id])
      redirect_to music_session_path(params[:music_session_id])
    end
  end

  private
  def entry_music_params
    params.require(:entry_music).permit(:music_name, :artist_name, :youtube_url).merge(user_id: current_user.id, session_id: params[:music_session_id])
  end

  def entry_part_params
    params.require(:entry_music)
          .permit(:vo, :cho, :gt1, :gt2, :ba, :dr, :key)
  end
end
