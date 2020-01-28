class EntryMusicsController < ApplicationController

  before_action :sign_in_check, only: [:create, :edit, :update, :destroy]
  before_action :set_session_entry_music, only: [:show, :edit, :update]

  def show
    @current_user_entry = @session.current_user_entry_judge(current_user)
    @entry_parts = @entry_music.entry_parts
  end

  def create
    begin
      # トランザクション開始
      ActiveRecord::Base.transaction do
        
        @entry_music = EntryMusic.new(entry_music_params)
        @entry_music.edit_youtube_url
        # エントリー曲の保存成功時
        if @entry_music.save!
          # 各パートの登録処理(Vo〜Key)
          entry_part_params_array = entry_part_params.to_h.to_a
          entry_part_params_array.each_with_index do |param, cnt|
            entry_part = EntryPart.new
            entry_part.set_default_part(params[:music_session_id], @entry_music.id, param, cnt)
            entry_part.save!
          end
        end
      end
      redirect_to music_session_path(params[:music_session_id])
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

  def edit
    @entry_parts = @entry_music.entry_parts
  end

  def update
    begin
      @entry_music.youtube_url = entry_music_params[:youtube_url]
      @entry_music.edit_youtube_url
      @entry_parts = @entry_music.entry_parts
      # エントリー曲の更新
      @entry_music.update!(entry_music_params)
      flash[:notice] = '変更を保存しました'
      redirect_to action: :show
    rescue ActiveRecord::RecordInvalid => e
      render :edit
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

  def destroy
    EntryMusic.destroy(params[:id])
    redirect_to music_session_path(params[:music_session_id])
  end

  private
  def entry_music_params
    params.require(:entry_music).permit(:music_name, :artist_name, :youtube_url).merge(user_id: current_user.id, session_id: params[:music_session_id])
  end

  def entry_part_params
    params.require(:entry_music)
          .permit(:vo, :cho, :gt1, :gt2, :ba, :dr, :key)
  end

  def sign_in_check
    unless user_signed_in?
      flash[:notice] = 'ログイン後（または会員登録後）を行ってください'
      redirect_to new_user_session_path
    end
  end

  def set_session_entry_music
    @session = Session.find(params[:music_session_id])
    @entry_music = EntryMusic.find(params[:id])
  end
end
