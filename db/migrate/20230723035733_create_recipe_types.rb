class CreateRecipeTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_types do |t|
      t.string :name
      t.string :category
      t.integer :license_tier
      t.decimal :sort_order

      t.timestamps
    end
  end
end
