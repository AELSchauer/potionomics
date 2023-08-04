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

ActiveRecord::Schema[7.0].define(version: 2023_08_04_172721) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brew_recipes", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "cupboard_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cupboard_id"], name: "index_brew_recipes_on_cupboard_id"
    t.index ["recipe_id"], name: "index_brew_recipes_on_recipe_id"
  end

  create_table "cauldrons", force: :cascade do |t|
    t.string "name"
    t.integer "tier"
    t.integer "max_ingredients"
    t.integer "max_magimins"
    t.bigint "upgrade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["upgrade_id"], name: "index_cauldrons_on_upgrade_id"
  end

  create_table "cupboard_cauldrons", force: :cascade do |t|
    t.bigint "cupboard_id", null: false
    t.bigint "cauldron_id", null: false
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cauldron_id"], name: "index_cupboard_cauldrons_on_cauldron_id"
    t.index ["cupboard_id"], name: "index_cupboard_cauldrons_on_cupboard_id"
  end

  create_table "cupboard_ingredients", force: :cascade do |t|
    t.bigint "cupboard_id", null: false
    t.bigint "ingredient_id", null: false
    t.integer "quantity", default: 0
    t.integer "quinn_location", default: -1
    t.boolean "discovered", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cupboard_id", "ingredient_id"], name: "index_cupboard_ingredients_on_cupboard_id_and_ingredient_id", unique: true
    t.index ["cupboard_id"], name: "index_cupboard_ingredients_on_cupboard_id"
    t.index ["ingredient_id"], name: "index_cupboard_ingredients_on_ingredient_id"
  end

  create_table "cupboards", force: :cascade do |t|
    t.integer "highest_license_tier", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "name"
    t.index ["user_id"], name: "index_cupboards_on_user_id"
  end

  create_table "favorite_recipes", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "cupboard_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cupboard_id"], name: "index_favorite_recipes_on_cupboard_id"
    t.index ["recipe_id"], name: "index_favorite_recipes_on_recipe_id"
  end

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

  create_table "recipe_ingredients", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id", "ingredient_id"], name: "index_recipe_ingredients_on_recipe_id_and_ingredient_id", unique: true
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipe_types", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "license_tier"
    t.decimal "sort_order"
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
    t.integer "sort_order"
    t.bigint "recipe_type_id"
    t.index ["cost_per_potion"], name: "index_recipes_on_cost_per_potion"
    t.index ["license_tier"], name: "index_recipes_on_license_tier"
    t.index ["num_of_ingredients"], name: "index_recipes_on_num_of_ingredients"
    t.index ["profit_ratio"], name: "index_recipes_on_profit_ratio"
    t.index ["recipe_type_id"], name: "index_recipes_on_recipe_type_id"
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

  add_foreign_key "brew_recipes", "cupboards"
  add_foreign_key "brew_recipes", "recipes"
  add_foreign_key "cauldrons", "cauldrons", column: "upgrade_id"
  add_foreign_key "cupboard_cauldrons", "cauldrons"
  add_foreign_key "cupboard_cauldrons", "cupboards"
  add_foreign_key "cupboard_ingredients", "cupboards"
  add_foreign_key "cupboard_ingredients", "ingredients"
  add_foreign_key "favorite_recipes", "cupboards"
  add_foreign_key "favorite_recipes", "recipes"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipes", "recipe_types"

  create_view "recipe_optimizations", sql_definition: <<-SQL
      SELECT DISTINCT concat(recipes.id, '-', cupboards.id) AS id,
      cupboards.id AS cupboard_id,
      recipes.id AS recipe_id,
      recipes.recipe_type_id,
      recipes.is_perfect,
      recipes.num_of_ingredients,
      recipes.num_of_potions,
      recipes.rarity,
      recipes.stars,
      recipes.total_magimins,
      recipes.value,
      recipes.cost,
      round(recipes.cost_per_potion, 2) AS cost_per_potion,
      recipes.profit,
      (recipes.profit - recipes.cost) AS profit_margin,
      round(((recipes.profit - recipes.cost) / (recipes.num_of_potions)::numeric), 2) AS profit_margin_per_potion,
      ((sum(
          CASE
              WHEN ((COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0) THEN ((recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price)
              ELSE 0
          END))::numeric * 1.0) AS calculated_cost,
      round(((sum(
          CASE
              WHEN ((COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0) THEN ((recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price)
              ELSE 0
          END))::numeric / ((recipes.num_of_potions)::numeric * 1.0)), 2) AS calculated_cost_per_potion,
      (recipes.value - (sum(
          CASE
              WHEN ((COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0) THEN ((recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price)
              ELSE 0
          END))::numeric) AS calculated_profit,
      round(((recipes.value - (sum(
          CASE
              WHEN ((COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0) THEN ((recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price)
              ELSE 0
          END))::numeric) - ((sum(
          CASE
              WHEN ((COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0) THEN ((recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price)
              ELSE 0
          END))::numeric * 1.0)), 2) AS calculated_profit_margin,
      round((((recipes.value - (sum(
          CASE
              WHEN ((COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0) THEN ((recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price)
              ELSE 0
          END))::numeric) - ((sum(
          CASE
              WHEN ((COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0) THEN ((recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price)
              ELSE 0
          END))::numeric * 1.0)) / (recipes.num_of_potions)::numeric), 2) AS calculated_profit_margin_per_potion,
      array_agg(recipe_ingredients.id) AS recipe_ingredient_ids,
      array_agg(cupboard_ingredients.id) AS cupboard_ingredient_ids,
      (false = ANY (array_agg(cupboard_ingredients.discovered))) AS undiscovered_cupboard_ingredients
     FROM (((((recipes
       JOIN recipe_ingredients ON ((recipe_ingredients.recipe_id = recipes.id)))
       JOIN ingredients ON ((ingredients.id = recipe_ingredients.ingredient_id)))
       JOIN cupboard_ingredients ON ((cupboard_ingredients.ingredient_id = ingredients.id)))
       JOIN cupboards ON ((cupboard_ingredients.cupboard_id = cupboards.id)))
       JOIN recipe_types ON ((recipes.recipe_type_id = recipe_types.id)))
    WHERE (cupboards.highest_license_tier >= recipes.license_tier)
    GROUP BY recipes.id, recipe_types.name, cupboards.id
    ORDER BY recipes.id, cupboards.id;
  SQL
  create_view "recipe_optimization_ingredients", sql_definition: <<-SQL
      SELECT DISTINCT cupboard_ingredients.cupboard_id,
      recipe_ingredients.id AS recipe_id,
      ingredients.id AS ingredient_id,
      ingredients.name,
      recipe_ingredients.quantity AS needed_quantity,
      cupboard_ingredients.quantity AS actual_quantity
     FROM ((cupboard_ingredients
       JOIN ingredients ON ((ingredients.id = cupboard_ingredients.ingredient_id)))
       JOIN recipe_ingredients ON ((ingredients.id = recipe_ingredients.ingredient_id)));
  SQL
end
