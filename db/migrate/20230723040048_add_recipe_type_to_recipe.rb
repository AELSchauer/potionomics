class AddRecipeTypeToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :recipe_type, foreign_key: true
  end
end
