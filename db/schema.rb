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

ActiveRecord::Schema.define(version: 20131125151903) do

  create_table "budgets", force: true do |t|
    t.string   "amount"
    t.string   "reason"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "budget_type"
  end

  create_table "muzikususers", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sid"
    t.boolean  "isyk"
    t.boolean  "ismyk"
    t.boolean  "isdavul"
    t.boolean  "isworkshop"
  end

  create_table "reservations", force: true do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "isCanceled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day"
    t.text     "info"
    t.integer  "hour"
  end

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roomschedules", force: true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "room_id"
    t.integer  "day"
  end

  create_table "scouts", force: true do |t|
    t.string   "BirinciEns"
    t.string   "BirinciSev"
    t.string   "BirinciYil"
    t.string   "IkinciEns"
    t.string   "IkinciSev"
    t.string   "IkinciYil"
    t.string   "VokalYetenek"
    t.string   "SahneTecrubesi"
    t.text     "UyeGruplar"
    t.text     "SevdiginGruplar"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supports", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "sabancimail"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "birthday"
  end

end
