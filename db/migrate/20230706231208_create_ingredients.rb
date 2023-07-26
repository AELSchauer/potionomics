class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :rarity
      t.string :category
      t.string :location
      t.integer :base_price
      t.integer :a_magimins, default: 0
      t.integer :b_magimins, default: 0
      t.integer :c_magimins, default: 0
      t.integer :d_magimins, default: 0
      t.integer :e_magimins, default: 0
      t.integer :total_magimins
      t.integer :taste_val, default: 0
      t.integer :touch_val, default: 0
      t.integer :smell_val, default: 0
      t.integer :sight_val, default: 0
      t.integer :sound_val, default: 0

      t.timestamps
    end
  end
end
