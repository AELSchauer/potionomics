class RecipeOptimization < ApplicationRecord
  self.primary_key = :cupboard_id, :recipe_id

  belongs_to :cupboard, foreign_key: 'cupboard_id', primary_key: 'id', class_name: 'Cupboard'
  belongs_to :recipe, foreign_key: 'recipe_id', primary_key: 'id', class_name: 'Recipe'
  belongs_to :recipe_type, foreign_key: 'recipe_type_id', primary_key: 'id', class_name: 'RecipeType'

  scope :ready_to_brew, -> { where(calculated_cost: 0) }
  scope :purchasable, -> { where(undiscovered_cupboard_ingredients: false).where('calculated_cost > 0') }
  scope :undiscovered, -> { where(undiscovered_cupboard_ingredients: true) }

  delegate  :display_cost, :display_cost_per_potion, :display_ingredients, :display_profit,
            :display_profit_margin, :display_profit_margin_per_potion, :display_rarity,
            :display_rarity_color, :display_name_color, to: :decorator

  delegate :name, to: :recipe_type

  def decorator
    RecipeOptimizationDecorator.new(self)
  end

  def recipe_ingredients
    RecipeIngredient.where(id: recipe_ingredient_ids)
  end

  def cupboard_ingredients
    CupboardIngredient.where(id: cupboard_ingredient_ids)
  end

  def recipe_optimization_ingredients
    RecipeOptimizationIngredient.where(cupboard_id:, recipe_id:)
  end

  def ready_to_brew?
    calculated_cost.zero?
  end
end
