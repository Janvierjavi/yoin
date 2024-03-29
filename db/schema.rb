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

ActiveRecord::Schema.define(version: 2019_06_20_081450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "senryu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["senryu_id"], name: "index_favorites_on_senryu_id"
    t.index ["user_id", "senryu_id"], name: "index_favorites_on_user_id_and_senryu_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "senryus", force: :cascade do |t|
    t.string "first_line", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "second_line", null: false
    t.string "third_line", null: false
    t.bigint "user_id"
    t.integer "favorites_count"
    t.index ["first_line"], name: "index_senryus_on_first_line"
    t.index ["second_line"], name: "index_senryus_on_second_line"
    t.index ["third_line"], name: "index_senryus_on_third_line"
    t.index ["user_id"], name: "index_senryus_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.text "icon"
    t.string "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "favorites", "senryus"
  add_foreign_key "favorites", "users"
  add_foreign_key "senryus", "users"
end
