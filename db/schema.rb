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

  create_table "budgets", force: :cascade do |t|
    t.string   "amount",      limit: 255
    t.string   "reason",      limit: 255
    t.string   "user_id",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "budget_type", limit: 255
  end

  create_table "muzikususers", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sid",        limit: 4
    t.boolean  "isyk",       limit: 1
    t.boolean  "ismyk",      limit: 1
    t.boolean  "isdavul",    limit: 1
    t.boolean  "isworkshop", limit: 1
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "room_id",    limit: 4
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "isCanceled", limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day",        limit: 4
    t.text     "info",       limit: 65535
    t.integer  "hour",       limit: 4
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "officer",      limit: 255, null: false
    t.string   "officer_num",  limit: 255, null: false
    t.string   "officer_mail", limit: 255, null: false
  end

  create_table "roomschedules", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "room_id",    limit: 4
    t.integer  "day",        limit: 4
  end

  create_table "scouts", force: :cascade do |t|
    t.string   "BirinciEns",      limit: 255
    t.string   "BirinciSev",      limit: 255
    t.string   "BirinciYil",      limit: 255
    t.string   "IkinciEns",       limit: 255
    t.string   "IkinciSev",       limit: 255
    t.string   "IkinciYil",       limit: 255
    t.string   "VokalYetenek",    limit: 255
    t.string   "SahneTecrubesi",  limit: 255
    t.text     "UyeGruplar",      limit: 65535
    t.text     "SevdiginGruplar", limit: 65535
    t.integer  "user_id",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supports", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "subject",    limit: 255
    t.text     "message",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "name",             limit: 255
    t.string   "email",            limit: 255
    t.string   "sabancimail",      limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "birthday"
  end

end
