class RecipeOptimizationIngredient < ApplicationRecord
  self.primary_key = :cupboard_id, :recipe_id

  belongs_to :cupboard, foreign_key: 'cupboard_id', primary_key: 'id', class_name: 'Cupboard'
  belongs_to :recipe, foreign_key: 'recipe_id', primary_key: 'id', class_name: 'Recipe'
end
