class CreateRecipeOptimizationIngredients < ActiveRecord::Migration[7.0]
  def change
    create_view :recipe_optimization_ingredients
  end
end
