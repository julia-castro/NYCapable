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

ActiveRecord::Schema.define(version: 20150717160531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "route_stations", force: :cascade do |t|
    t.integer  "route_id"
    t.integer  "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.string   "route_id"
    t.string   "agency_id"
    t.string   "route_short_name"
    t.string   "route_long_name"
    t.string   "route_desc"
    t.string   "route_type"
    t.string   "route_url"
    t.string   "route_color"
    t.string   "route_text_color"
    t.string   "service_status",      default: ""
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "service_status_note", default: ""
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.boolean  "accessible"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "ramp"
    t.boolean  "elevator"
    t.string   "notes"
    t.boolean  "transferable"
    t.string   "transferable_to"
    t.float    "distance_to"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
