# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140527213729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "artists", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mbid"
  end

  create_table "attended_concerts", force: true do |t|
    t.integer  "concert_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attended_concerts", ["concert_id"], name: "index_attended_concerts_on_concert_id", using: :btree
  add_index "attended_concerts", ["user_id"], name: "index_attended_concerts_on_user_id", using: :btree

  create_table "concert_artists", force: true do |t|
    t.integer  "concert_id"
    t.integer  "artist_id"
    t.string   "concert_position", default: "Headliner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concert_artists", ["artist_id"], name: "index_concert_artists_on_artist_id", using: :btree
  add_index "concert_artists", ["concert_id"], name: "index_concert_artists_on_concert_id", using: :btree

  create_table "concert_photos", force: true do |t|
    t.integer  "user_id"
    t.integer  "concert_id"
    t.string   "image",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concert_photos", ["concert_id"], name: "index_concert_photos_on_concert_id", using: :btree
  add_index "concert_photos", ["user_id"], name: "index_concert_photos_on_user_id", using: :btree

  create_table "concert_songs", force: true do |t|
    t.integer  "order",      null: false
    t.integer  "concert_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concert_songs", ["concert_id"], name: "index_concert_songs_on_concert_id", using: :btree
  add_index "concert_songs", ["song_id"], name: "index_concert_songs_on_song_id", using: :btree

  create_table "concerts", force: true do |t|
    t.date     "date",       null: false
    t.integer  "venue_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concerts", ["venue_id"], name: "index_concerts_on_venue_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "setlists", force: true do |t|
    t.text     "data"
    t.integer  "concert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "setlists", ["concert_id"], name: "index_setlists_on_concert_id", using: :btree

  create_table "songs", force: true do |t|
    t.string   "title",      null: false
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  create_table "venues", force: true do |t|
    t.string   "name",       null: false
    t.string   "city",       null: false
    t.string   "state",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "identifier"
    t.integer  "concert_song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["concert_song_id"], name: "index_videos_on_concert_song_id", using: :btree

end
