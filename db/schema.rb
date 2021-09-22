# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_24_062219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banned_users", force: :cascade do |t|
    t.integer "user"
    t.datetime "banned_until"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "budgets", force: :cascade do |t|
    t.integer "amount"
    t.string "reason"
    t.string "budget_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "details"
    t.string "location"
    t.datetime "starts_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "faculty_lessons", force: :cascade do |t|
    t.bigint "teacher_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_faculty_lessons_on_teacher_id"
  end

  create_table "faculty_students", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "faculty_lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_lesson_id"], name: "index_faculty_students_on_faculty_lesson_id"
    t.index ["user_id"], name: "index_faculty_students_on_user_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "category"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lesson_schedules", force: :cascade do |t|
    t.bigint "faculty_lesson_id"
    t.bigint "room_id"
    t.string "weekday"
    t.time "start_at"
    t.time "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_lesson_id"], name: "index_lesson_schedules_on_faculty_lesson_id"
    t.index ["room_id"], name: "index_lesson_schedules_on_room_id"
  end

  create_table "managers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.string "manager_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_managers_on_room_id"
    t.index ["user_id"], name: "index_managers_on_user_id"
  end

  create_table "musician_infos", force: :cascade do |t|
    t.bigint "scout_profile_id"
    t.bigint "instrument_id"
    t.string "experience"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_musician_infos_on_instrument_id"
    t.index ["scout_profile_id"], name: "index_musician_infos_on_scout_profile_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean "is_canceled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "detail"
    t.index ["room_id"], name: "index_reservations_on_room_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scout_profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "birthday"
    t.string "stage_exp"
    t.string "vocal_exp"
    t.text "bio"
    t.boolean "is_hidden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_scout_profiles_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "email"
    t.string "phone_num"
    t.boolean "is_member"
    t.boolean "is_yk"
    t.boolean "is_myk"
    t.boolean "is_workshop"
    t.boolean "is_drum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
