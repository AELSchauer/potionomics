class CreateCupboardIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :cupboard_ingredients do |t|
      t.references :cupboard, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.integer :quantity, default: 0
      t.integer :quinn_location, default: -1
      t.boolean :discovered, default: false

      t.timestamps
    end

    add_index :cupboard_ingredients, %i[cupboard_id ingredient_id], unique: true
  end
end
