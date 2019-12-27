class EntryPart < ApplicationRecord

  belongs_to :entry_music
  belongs_to :user, optional: true

  def set_db(entry_music_id, param, cnt)
    
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
end
