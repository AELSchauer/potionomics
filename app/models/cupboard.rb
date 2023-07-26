class Cupboard < ApplicationRecord
  has_many :cupboard_ingredients
  has_many :ingredients, through: :cupboard_ingredients
  has_many :cupboard_cauldrons
  has_many :cauldrons, through: :cupboard_cauldrons
  has_many :recipe_optimizations
  has_many :favorite_recipes
  has_many :brew_recipes
  belongs_to :user

  after_create do
    Ingredient.all.each do |ingredient|
      CupboardIngredient.create(cupboard: self, ingredient: ingredient)
    end
  end

  # after_save :optimize_recipes

  def available_recipes
    Recipe.where("license_tier <= ?", highest_license_tier)
  end

  def unoptimized_recipes
    available_recipes.where.not(id: recipe_optimizations.pluck(:recipe_id))
  end

  def optimize_recipes
    recipe_optimizations.each do |recipe_optimization|
      recipe_optimization.update_cost_to_make
      recipe_optimization.save
    end
    unoptimized_recipes.pluck(:id).each do |recipe_id|
      RecipeOptimization.find_or_create_by(recipe_id: recipe_id, cupboard_id: self.id)
    end
  end

  def recipe_optimizer_up_to_date?
    recipe_optimizations.out_of_date(self).none?
  end
end
