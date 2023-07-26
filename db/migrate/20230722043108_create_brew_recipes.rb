class CreateBrewRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :brew_recipes do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :cupboard, null: false, foreign_key: true

      t.timestamps
    end
  end
end
