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

ActiveRecord::Schema[7.0].define(version: 2023_07_06_231839) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "rarity"
    t.string "category"
    t.string "location"
    t.integer "base_price"
    t.integer "a_magimins", default: 0
    t.integer "b_magimins", default: 0
    t.integer "c_magimins", default: 0
    t.integer "d_magimins", default: 0
    t.integer "e_magimins", default: 0
    t.integer "total_magimins"
    t.integer "taste_val", default: 0
    t.integer "touch_val", default: 0
    t.integer "smell_val", default: 0
    t.integer "sight_val", default: 0
    t.integer "sound_val", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "category"
    t.boolean "is_perfect"
    t.integer "num_of_potions"
    t.integer "num_of_ingredients"
    t.integer "license_tier"
    t.integer "rarity"
    t.integer "stars"
    t.integer "total_magimins"
    t.decimal "cost"
    t.decimal "cost_per_potion"
    t.decimal "value"
    t.decimal "profit"
    t.decimal "profit_ratio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "value_per_potion"
    t.string "name"
    t.index ["cost_per_potion"], name: "index_recipes_on_cost_per_potion"
    t.index ["license_tier"], name: "index_recipes_on_license_tier"
    t.index ["num_of_ingredients"], name: "index_recipes_on_num_of_ingredients"
    t.index ["profit_ratio"], name: "index_recipes_on_profit_ratio"
    t.index ["total_magimins"], name: "index_recipes_on_total_magimins"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
