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

ActiveRecord::Schema[7.0].define(version: 2024_06_02_133703) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.bigint "prefecture_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_areas_on_prefecture_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_favorites_on_shop_id"
    t.index ["user_id", "shop_id"], name: "index_favorites_on_user_id_and_shop_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "nices", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "review_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_nices_on_review_id"
    t.index ["user_id", "review_id"], name: "index_nices_on_user_id_and_review_id", unique: true
    t.index ["user_id"], name: "index_nices_on_user_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_prefectures_on_name", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", limit: 30, default: "名無しのヒトカラー", null: false
    t.integer "gender", default: 0, null: false
    t.integer "age_group", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "shop_id", null: false
    t.integer "minimal_interaction", default: 3, null: false
    t.integer "equipment_customization", default: 3, null: false
    t.integer "solo_friendly", default: 3, null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_reviews_on_shop_id"
    t.index ["user_id", "shop_id"], name: "index_reviews_on_user_id_and_shop_id", unique: true
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shop_tags", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id", "tag_id"], name: "index_shop_tags_on_shop_id_and_tag_id", unique: true
    t.index ["shop_id"], name: "index_shop_tags_on_shop_id"
    t.index ["tag_id"], name: "index_shop_tags_on_tag_id"
  end

  create_table "shops", force: :cascade do |t|
    t.bigint "area_id", null: false
    t.string "name", null: false
    t.string "address", null: false
    t.string "phone_number"
    t.string "url"
    t.string "opening_hours"
    t.decimal "latitude", precision: 9, scale: 6, null: false
    t.decimal "longitude", precision: 9, scale: 6, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "int_average", default: 0, null: false
    t.integer "eqcust_average", default: 0, null: false
    t.integer "sofr_average", default: 0, null: false
    t.index ["area_id"], name: "index_shops_on_area_id"
    t.index ["name", "address"], name: "index_shops_on_name_and_address", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "crypted_password"
    t.string "salt"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "areas", "prefectures"
  add_foreign_key "favorites", "shops"
  add_foreign_key "favorites", "users"
  add_foreign_key "nices", "reviews"
  add_foreign_key "nices", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "reviews", "shops"
  add_foreign_key "reviews", "users"
  add_foreign_key "shop_tags", "shops"
  add_foreign_key "shop_tags", "tags"
  add_foreign_key "shops", "areas"
end
