class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :category
      t.boolean :is_perfect
      t.integer :num_of_potions
      t.integer :num_of_ingredients
      t.integer :license_tier
      t.integer :rarity
      t.integer :stars
      t.integer :total_magimins
      t.decimal :cost
      t.decimal :cost_per_potion
      t.decimal :value
      t.decimal :profit
      t.decimal :profit_ratio

      t.timestamps
    end

    add_index :recipes, :name
    add_index :recipes, :num_of_ingredients
    add_index :recipes, :total_magimins
    add_index :recipes, :cost_per_potion
    add_index :recipes, :profit_ratio
    add_index :recipes, :license_tier
  end
end
