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

ActiveRecord::Schema[7.0].define(version: 2023_03_17_160432) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "checked", default: false, null: false
  end

  create_table "trends", force: :cascade do |t|
    t.string "name", null: false
    t.integer "popularity", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count", null: false
    t.index ["category_id"], name: "index_trends_on_category_id"
    t.index ["count"], name: "index_trends_on_count"
    t.index ["name"], name: "index_trends_on_name"
    t.index ["popularity"], name: "index_trends_on_popularity"
  end

  create_table "tweets", force: :cascade do |t|
    t.text "message"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "nickname", null: false
    t.string "phone_number"
    t.string "email"
    t.date "birthday", null: false
    t.text "introduction"
    t.string "residence"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["nickname"], name: "index_users_on_nickname"
    t.index ["password"], name: "index_users_on_password"
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["website"], name: "index_users_on_website", unique: true
  end

  add_foreign_key "trends", "categories"
  add_foreign_key "tweets", "users"
end
