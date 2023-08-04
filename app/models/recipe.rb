class Recipe < ApplicationRecord
  belongs_to :recipe_type
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  delegate :display_rarity_color, to: :decorator

  def decorator
    RecipeOptimizationDecorator.new(self)
  end

  def calculate_data
    self.total_magimins = recipe_ingredients.map(&:total_magimins).sum
    self.num_of_ingredients = recipe_ingredients.sum(:quantity)
    self.cost = recipe_ingredients.map(&:total_cost).sum
    self.cost_per_potion = (cost / num_of_potions)
    self.profit = value - cost
    self.profit_ratio = (profit / cost).round(3)
    save!
  end
end
