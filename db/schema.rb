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

ActiveRecord::Schema.define(version: 20140522194740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attended_concerts", force: true do |t|
    t.integer  "concert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attended_concerts", ["concert_id"], name: "index_attended_concerts_on_concert_id", using: :btree

  create_table "concert_artists", force: true do |t|
    t.string   "concert_position", null: false
    t.integer  "concert_id"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concert_artists", ["artist_id"], name: "index_concert_artists_on_artist_id", using: :btree
  add_index "concert_artists", ["concert_id"], name: "index_concert_artists_on_concert_id", using: :btree

  create_table "concerts", force: true do |t|
    t.date     "date",       null: false
    t.integer  "venue_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concerts", ["venue_id"], name: "index_concerts_on_venue_id", using: :btree

  create_table "songs", force: true do |t|
    t.string   "title",      null: false
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id", using: :btree

  create_table "venues", force: true do |t|
    t.string   "name",       null: false
    t.string   "location",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "video_identifier", null: false
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["song_id"], name: "index_videos_on_song_id", using: :btree

end
