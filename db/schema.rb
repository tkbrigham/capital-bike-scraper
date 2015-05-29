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

ActiveRecord::Schema.define(version: 20150521035005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "station_availabilities", force: :cascade do |t|
    t.integer "station_id"
    t.decimal "average_bikes"
    t.decimal "average_docks"
    t.integer "day_of_week"
    t.integer "time_integer"
  end

  add_index "station_availabilities", ["station_id"], name: "index_station_availabilities_on_station_id", using: :btree

  create_table "station_stats", force: :cascade do |t|
    t.integer  "station_id"
    t.datetime "scrape_timestamp"
    t.datetime "cb_latest_update_time"
    t.integer  "bikes_available"
    t.integer  "docks_available"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "station_stats", ["station_id"], name: "index_station_stats_on_station_id", using: :btree

  create_table "stations", force: :cascade do |t|
    t.integer  "cb_id"
    t.string   "name"
    t.integer  "terminal_id"
    t.datetime "last_comm_with_server"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.boolean  "installed"
    t.boolean  "locked"
    t.datetime "install_date"
    t.datetime "removal_date"
    t.boolean  "temporary"
    t.boolean  "public"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "stations", ["cb_id"], name: "index_stations_on_cb_id", using: :btree

end
