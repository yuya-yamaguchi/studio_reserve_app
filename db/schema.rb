# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_24_110806) do

  create_table "active_admin_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "chatrooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entry_musics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "session_id", null: false
    t.string "music_name", null: false
    t.string "artist_name", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "youtube_url"
    t.text "youtube_url_embed"
    t.index ["session_id"], name: "index_entry_musics_on_session_id"
    t.index ["user_id"], name: "index_entry_musics_on_user_id"
  end

  create_table "entry_parts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "entry_music_id", null: false
    t.bigint "user_id"
    t.integer "part_no", null: false
    t.string "part_name", null: false
    t.integer "apply_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "session_id"
    t.index ["entry_music_id"], name: "index_entry_parts_on_entry_music_id"
    t.index ["session_id"], name: "index_entry_parts_on_session_id"
    t.index ["user_id"], name: "index_entry_parts_on_user_id"
  end

  create_table "entry_rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chatroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_entry_rooms_on_chatroom_id"
    t.index ["user_id"], name: "index_entry_rooms_on_user_id"
  end

  create_table "entry_sessions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "session_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_entry_sessions_on_session_id"
    t.index ["user_id"], name: "index_entry_sessions_on_user_id"
  end

  create_table "error_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "controller"
    t.string "action"
    t.string "ip_address"
    t.text "message"
    t.text "parameters"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chatroom_id", null: false
    t.text "text"
    t.integer "read_flg", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "contents", null: false
    t.integer "notice_type", null: false
    t.integer "read_flg", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "contents", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "post_type", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "reserves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "studio_id", null: false
    t.date "date", null: false
    t.integer "hour", null: false
    t.integer "reserve_flg", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["studio_id"], name: "index_reserves_on_studio_id"
    t.index ["user_id"], name: "index_reserves_on_user_id"
  end

  create_table "sessions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "studio_id", null: false
    t.bigint "user_reserve_id", null: false
    t.string "title", null: false
    t.text "explain", null: false
    t.date "date", null: false
    t.integer "start_hour", null: false
    t.integer "end_hour", null: false
    t.integer "max_music", null: false
    t.string "entry_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "img"
    t.index ["studio_id"], name: "index_sessions_on_studio_id"
    t.index ["user_id"], name: "index_sessions_on_user_id"
    t.index ["user_reserve_id"], name: "index_sessions_on_user_reserve_id"
  end

  create_table "studios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "fee", default: 0, null: false
    t.string "guitar_amp"
    t.string "bass_amp"
    t.string "drums"
    t.string "keybords"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "size"
    t.text "explain"
  end

  create_table "user_reserves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "studio_id", null: false
    t.date "reserve_date", null: false
    t.integer "start_hour", null: false
    t.integer "end_hour", null: false
    t.integer "payment_fee", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["studio_id"], name: "index_user_reserves_on_studio_id"
    t.index ["user_id"], name: "index_user_reserves_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "tel_no", default: "", null: false
    t.string "img", default: ""
    t.text "profile"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin_flg", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "entry_parts", "sessions"
  add_foreign_key "reserves", "users"
end
