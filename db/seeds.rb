# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# studios初期データ
Studio.create!(name: "studio A", fee: 1600, guitar_amp: "Marshall JCM900, Roland JC-120", bass_amp: "HARTKE HA2500", drums: "CANOPUS Japanese Sword", keybords: "YAMAHA MO888", size: 24.0)
Studio.create!(name: "studio B", fee: 1200, guitar_amp: "Marshall JCM900, Roland JC-120", bass_amp: "HARTKE HA2500", drums: "CANOPUS Japanese Sword", keybords: "YAMAHA MO888", size: 12.0)
Studio.create!(name: "studio C", fee: 1000, guitar_amp: "Marshall JCM900, Roland JC-120", bass_amp: "HARTKE HA2500", drums: "CANOPUS Japanese Sword", keybords: "YAMAHA MO888", size: 10.0)
Studio.create!(name: "studio D", fee:  800, guitar_amp: "Marshall JCM900, Roland JC-120", bass_amp: "HARTKE HA2500", drums: "CANOPUS Japanese Sword", keybords: "YAMAHA MO888", size: 8.0)

# reserves初期データ(起動日から1年分を作成)
require 'date'
today = Date.today
hour = 10
date_cnt = 0
if Rails.env == "development"
  # スタジオ単位
  4.times do |i|
    # 日単位
    while date_cnt < 365 do
      # 時間単位
      while hour < 22 do
        Reserve.create!(studio_id: i + 1, date: today + date_cnt, hour: hour, reserve_flg: 0)
        hour += 1
      end
      hour = 10
      date_cnt += 1
    end
    date_cnt = 0
  end
end
