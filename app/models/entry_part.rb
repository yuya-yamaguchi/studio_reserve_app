class EntryPart < ApplicationRecord

  belongs_to :entry_music
  belongs_to :user, optional: true

  def set_default_part(session_id, entry_music_id, param, cnt)
    
    self.session_id     = session_id
    self.entry_music_id = entry_music_id
    self.part_no = cnt + 1
    self.part_name = param[0]

    case param[1]
    when "need"
      self.apply_status = 1
    when "whichever"
      self.apply_status = 2
    when "needless"
      self.apply_status = 3
    end
  end

  def entry_music_establish
    part_cnt = entry_music.entry_parts.where(apply_status: 1)
                                      .where(user_id: nil).count
    if part_cnt == 0
      entry_music.update(status: 1)
    else
      entry_music.update(status: 0)
    end
  end
end
