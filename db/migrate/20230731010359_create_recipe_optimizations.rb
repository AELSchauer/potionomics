class CreateRecipeOptimizations < ActiveRecord::Migration[7.0]
  def change
    create_view :recipe_optimizations
  end
end
