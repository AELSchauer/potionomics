class CreateCupboardIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :cupboard_ingredients do |t|
      t.references :cupboard, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.integer :quantity, default: 0
      t.integer :quinn_location_tab
      t.integer :quinn_location_slot

      t.timestamps
    end

    add_index :cupboard_ingredients, [:cupboard_id, :ingredient_id], unique: true
  end
end
