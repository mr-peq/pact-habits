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

ActiveRecord::Schema[7.1].define(version: 2023_12_03_184630) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "avatar_skills", force: :cascade do |t|
    t.bigint "avatar_id", null: false
    t.bigint "skill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avatar_id"], name: "index_avatar_skills_on_avatar_id"
    t.index ["skill_id"], name: "index_avatar_skills_on_skill_id"
  end

  create_table "avatars", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "health", default: 100
    t.integer "attack", default: 10
    t.integer "crit_rate", default: 2
    t.integer "magic_power", default: 10
    t.integer "defense", default: 10
    t.integer "mana", default: 100
    t.integer "speed", default: 10
    t.integer "stamina", default: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "magic_defense", default: 10
    t.integer "upgrade_points", default: 4
    t.bigint "level_id", null: false
    t.integer "xp", default: 0
    t.index ["level_id"], name: "index_avatars_on_level_id"
    t.index ["user_id"], name: "index_avatars_on_user_id"
  end

  create_table "beneficiaries", force: :cascade do |t|
    t.string "name"
    t.string "logo_src"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade do |t|
    t.integer "current", null: false
    t.integer "to_next"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pacts", force: :cascade do |t|
    t.string "category"
    t.integer "distance"
    t.integer "duration"
    t.boolean "recurring", default: false
    t.integer "weekdays", array: true
    t.integer "xp", default: 20
    t.integer "completion_duration"
    t.boolean "challenge", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "category"
    t.integer "dmg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "user_pacts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pact_id", null: false
    t.datetime "deadline_at"
    t.integer "bet"
    t.bigint "beneficiary_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beneficiary_id"], name: "index_user_pacts_on_beneficiary_id"
    t.index ["pact_id"], name: "index_user_pacts_on_pact_id"
    t.index ["user_id"], name: "index_user_pacts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.string "nickname"
    t.text "strava_token"
    t.integer "total_xp"
    t.integer "achieved_pacts"
    t.integer "failed_pacts"
    t.bigint "checked_strava_ids", default: [], array: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "avatar_skills", "avatars"
  add_foreign_key "avatar_skills", "skills"
  add_foreign_key "avatars", "levels"
  add_foreign_key "avatars", "users"
  add_foreign_key "user_pacts", "beneficiaries"
  add_foreign_key "user_pacts", "pacts"
  add_foreign_key "user_pacts", "users"
end
