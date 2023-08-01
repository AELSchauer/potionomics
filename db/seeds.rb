# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# CSV.foreach("./db/fixtures/Ingredients.csv", headers: true) do |row|
#   rarity = row["Rarity"].downcase.to_sym
#   ingredient_rarity = {
#     common: 1,
#     uncommon: 2,
#     rare: 3,
#     epic: 4
#   }
# Ingredient.find_or_create_by!(
#     name: row["Name"],
#     category: row["Type"],
#     location: row["Location"],
#     rarity: ingredient_rarity[rarity],
#     base_price: row["(Base) Price"].to_i,
#     a_magimins: row["A"].to_i,
#     b_magimins: row["B"].to_i,
#     c_magimins: row["C"].to_i,
#     d_magimins: row["D"].to_i,
#     e_magimins: row["E"].to_i
#   )
# end

user = User.create(email: "test@gmail.com", password: "password")
cupboard = Cupboard.create(highest_license_tier: 1, user: user)

# [
#   [
#     { name: "Health Potion", license_tier: 1 }, 
#     { name: "Mana Potion", license_tier: 1 }, 
#     { name: "Stamina Potion", license_tier: 2 }, 
#     { name: "Speed Potion", license_tier: 2 }, 
#     { name: "Tolerance Potion", license_tier: 4 }
#   ],
#   [
#     { name: "Fire Tonic", license_tier: 1 }, 
#     { name: "Ice Tonic", license_tier: 2 }, 
#     { name: "Thunder Tonic", license_tier: 2 }, 
#     { name: "Shadow Tonic", license_tier: 2 }, 
#     { name: "Radiation Tonic", license_tier: 4 }
#   ],
#   [
#     { name: "Sight Enhancer", license_tier: 1 }, 
#     { name: "Alertness Enhancer", license_tier: 2 }, 
#     { name: "Insight Enhancer", license_tier: 3 }, 
#     { name: "Dowsing Enhancer", license_tier: 3 }, 
#     { name: "Seeking Enhancer", license_tier: 4 }
#   ],
#   [
#     { name: "Poison Cure", license_tier: 1 }, 
#     { name: "Drowsiness Cure", license_tier: 2 }, 
#     { name: "Petrification Cure", license_tier: 3 }, 
#     { name: "Silence Cure", license_tier: 3 }, 
#     { name: "Curse Cure", license_tier: 4 }
#   ]
# ].each_with_index do |category, category_idx|
#   category.each_with_index do |recipe, recipe_idx|
#     RecipeType.find_or_create_by(
#       name: recipe[:name],
#       license_tier: recipe[:license_tier],
#       category: recipe[:name].split[1],
#       sort_order: "#{category_idx}.#{recipe_idx}")
#   end
# end

# CSV.foreach("./db/fixtures/Cauldrons.csv", headers: true) do |row|
#   Cauldron.find_or_create_by(
#     id: row["ID"].to_i,
#     name: row["Name"],
#     tier: row["Tier"].to_i,
#     max_ingredients: row["Max Ingredients"].to_i,
#     max_magimins: row["Max Magimins"].to_i,
#     upgrade: row["Upgrade ID"].nil? ? nil : Cauldron.find(row["Upgrade ID"])
#   )
# end

CupboardCauldron.create(cauldron: Cauldron.find_by(name: "Wooden", tier: 1), active: false, cupboard: cupboard)
CupboardCauldron.create(cauldron: Cauldron.find_by(name: "Clay", tier: 1), active: false, cupboard: cupboard)
CupboardCauldron.create(cauldron: Cauldron.find_by(name: "Glass", tier: 3), active: false, cupboard: cupboard)
CupboardCauldron.create(cauldron: Cauldron.find_by(name: "Storm", tier: 3), active: false, cupboard: cupboard)
CupboardCauldron.create(cauldron: Cauldron.find_by(name: "Ocean", tier: 1), active: false, cupboard: cupboard)
CupboardCauldron.create(cauldron: Cauldron.find_by(name: "Crystal", tier: 3), active: false, cupboard: cupboard)
CupboardCauldron.create(cauldron: Cauldron.find_by(name: "Celestial", tier: 3), active: false, cupboard: cupboard)
CupboardCauldron.create(cauldron: Cauldron.find_by(name: "Arctic", tier: 3), active: true, cupboard: cupboard)
CupboardCauldron.create(cauldron: Cauldron.find_by(name: "Arctic", tier: 3), active: true, cupboard: cupboard)
CupboardCauldron.create(cauldron: Cauldron.find_by(name: "Arctic", tier: 3), active: true, cupboard: cupboard)
CupboardCauldron.create(cauldron: Cauldron.find_by(name: "Dragon", tier: 3), active: false, cupboard: cupboard)
CupboardCauldron.create(cauldron: Cauldron.find_by(name: "Magical Wasteland", tier: 3), active: true, cupboard: Cupboard.first)

idx = 1
CSV.foreach("./db/fixtures/Cupboard.csv", headers: true) do |row|
  ci = CupboardIngredient.find_by(
    cupboard: cupboard,
    ingredient: Ingredient.find_by_name(row["Ingredient Name"])
  )
  ci.update(
    quantity: row["Quantity"].to_i,
    quinn_location: idx
  )
  idx += 1
  puts row["Ingredient Name"]
end

# CSV.foreach("./db/fixtures/Perfect Recipes.csv", headers: true) do |row|
#   ingredient_rarity = %w(Minor Common Greater Grand Superior Masterwork).index(row["Rarity"])
#   recipe = Recipe.create(
#     recipe_type: RecipeType.find_by(name: row["Recipe Name"]),
#     category: row["Recipe Name"].split(" ").last.downcase,
#     license_tier: row["Tier"].to_i,
#     is_perfect: true,
#     num_of_potions: row["Amount of Potions"].to_i,
#     rarity: ingredient_rarity,
#     stars: row["Stars"].to_i,
#     value: row["Value"].to_i
#   )
  
#   row["Recipe Summary"].split("\n").map {|data| data.match(/^(?<quantity>\d{1,2})x (?<name>[\w '-]*)$/)}.each do |data|
#     ingredient = Ingredient.find_by_name(data["name"])
#     RecipeIngredient.create(
#       recipe_id: recipe.id,
#       ingredient_id: ingredient.id,
#       quantity: data["quantity"]
#     )
#   end

#   recipe.calculate_data
#   byebug if ingredient_rarity.nil?
#   byebug if recipe_optimization.num_of_ingredients != row["Amount of Ingredients"].to_i
#   byebug if recipe_optimization.total_magimins != row["Total Magimin"].to_i
#   byebug if recipe_optimization.cost != row["Cost"].to_i
#   byebug if recipe_optimization.profit != row["Profit"].to_i
#   puts recipe.id
# end
