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

ActiveRecord::Schema.define(version: 20150317234100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "capital_scrapers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "station_stats", force: :cascade do |t|
    t.integer  "station_id"
    t.datetime "statusTime"
    t.integer  "cb_nbBikes"
    t.integer  "cb_nbEmptyDocks"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "station_stats", ["station_id"], name: "index_station_stats_on_station_id", using: :btree

  create_table "stations", force: :cascade do |t|
    t.integer  "cb_id"
    t.string   "cb_name"
    t.integer  "cb_terminalName"
    t.datetime "cb_lastCommWithServer"
    t.decimal  "cb_lat"
    t.decimal  "cb_long"
    t.boolean  "cb_installed"
    t.boolean  "cb_locked"
    t.datetime "cb_installDate"
    t.datetime "cb_removalDate"
    t.boolean  "cb_temporary"
    t.boolean  "cb_public"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.datetime "cb_latestUpdateTime"
  end

end
