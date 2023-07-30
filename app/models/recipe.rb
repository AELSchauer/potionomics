class Recipe < ApplicationRecord
  belongs_to :recipe_type
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  delegate  :display_cost, :display_cost_per_potion, :display_ingredients, :display_profit,
            :display_profit_ratio, :display_rarity, :display_rarity_color, :display_name_color, to: :decorator

  delegate :name, to: :recipe_type

  def self.all_tier_available_recipes(cupboard:)
    self.joins(recipe_ingredients: { ingredient: :cupboard_ingredients })
          .where("cupboard_ingredients.cupboard_id = #{cupboard.id}")
          .where("recipes.license_tier <= #{cupboard.highest_license_tier}")
  end

  def self.with_purchasable_ingredients(cupboard:)
    self.all_tier_available_recipes(cupboard: cupboard)
        .where("(recipe_ingredients.quantity - cupboard_ingredients.quantity) > 0")
        .where("cupboard_ingredients.quinn_location_tab IS NOT NULL")
        .where("cupboard_ingredients.quinn_location_slot IS NOT NULL")
        .distinct
  end

  def self.with_missing_ingredients(cupboard:)
    self.all_tier_available_recipes(cupboard: cupboard)
        .where("(recipe_ingredients.quantity - cupboard_ingredients.quantity) > 0")
        .distinct
  end

  def self.ready_to_brew(cupboard:)
    recipe_ids = self.all_tier_available_recipes(cupboard: cupboard)
        .group(:id)
        .having("SUM(CASE WHEN (COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0 THEN(COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) * ingredients.base_price ELSE 0 END) = 0")
        .distinct
        .pluck(:id)
    Recipe.where(id: recipe_ids)
  end

  def decorator
    RecipeDecorator.new(self)
  end

  def calculate_data
    self.total_magimins = recipe_ingredients.map(&:total_magimins).sum
    self.num_of_ingredients = recipe_ingredients.sum(:quantity)
    self.cost = recipe_ingredients.map(&:total_cost).sum
    self.cost_per_potion = (cost / num_of_potions)
    self.profit = value - cost
    self.profit_ratio = (profit / cost).round(3)
    self.save!
  end

  def ready_to_brew?(cupboard:)
    Recipe.ready_to_brew(cupboard: cupboard).include?(self)
  end
end


