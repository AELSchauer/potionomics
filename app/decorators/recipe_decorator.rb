class RecipeDecorator < ApplicationDecorator
  decorates :recipe
  include Draper::LazyHelpers

  def display_cost
    object.cost.round
  end

  def display_cost_per_potion
    object.cost_per_potion.round
  end

  def display_ingredients
    object.recipe_ingredients
          .includes(:ingredient)
          .pluck('recipe_ingredients.quantity', 'ingredients.name')
          .map { |data| data.join("x ") }
  end

  def display_profit
    object.profit.round
  end

  def display_profit_ratio
    sprintf("%0.03f", object.profit_ratio)
  end

  def display_rarity
    %w(Minor Common Greater Grand Superior Masterwork)[object.rarity]
  end

  def display_rarity_color
    case display_rarity
    when "Minor"
      "#eecdcd"
    when "Common"
      "#f8e6d0"
    when "Greater"
      "#fdf2d0"
    when "Grand"
      "#dce9d5"
    when "Superior"
      "#ccd9f5"
    when "Masterwork"
      "#d8d2e7"
    end
  end

  def display_name_color
    case object.name
    when "Health Potion"
      "#8f2725"
    when "Mana Potion"
      "#384d91"
    when "Stamina Potion"
      "#63ae23"
    when "Speed Potion"
      "#dfb734"
    when "Tolerance Potion"
      "#782448"
    when "Fire Tonic"
      "#d74e0f"
    when "Ice Tonic"
      "#6f92b7"
    when "Thunder Tonic"
      "#e1ce36"
    when "Shadow Tonic"
      "#4c3f90"
    when "Radiation Tonic"
      "#435115"
    when "Sight Enhancer"
      "#61abc5"
    when "Alertness Enhancer"
      "#bcb69d"
    when "Insight Enhancer"
      "#9270b3"
    when "Dowsing Enhancer"
      "#518c4a"
    when "Seeking Enhancer"
      "#d2686b"
    when "Poison Cure"
      "#5c356d"
    when "Drowsiness Cure"
      "#3c7d79"
    when "Petrification Cure"
      "#54554e"
    when "Silence Cure"
      "#d75360"
    when "Curse Cure"
      "#393b6b"
    end
  end
end
