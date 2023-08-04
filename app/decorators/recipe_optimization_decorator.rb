class RecipeOptimizationDecorator < ApplicationDecorator
  decorates :recipe_optimization
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
          .map { |data| data.join('x ') }
  end

  def display_profit
    object.profit.round
  end

  def display_profit_margin
    object.profit_margin.round
  end

  def display_profit_margin_per_potion
    object.profit_margin_per_potion.round
  end

  def display_rarity
    %w[Minor Common Greater Grand Superior Masterwork][object.rarity]
  end

  def display_rarity_color
    {
      'Minor' => '#eecdcd',
      'Common' => '#f8e6d0',
      'Greater' => '#fdf2d0',
      'Grand' => '#dce9d5',
      'Superior' => '#ccd9f5',
      'Masterwork' => '#d8d2e7'
    }[display_rarity]
  end

  def display_name_color
    {
      'Health Potion' => '#8f2725',
      'Mana Potion' => '#384d91',
      'Stamina Potion' => '#63ae23',
      'Speed Potion' => '#dfb734',
      'Tolerance Potion' => '#782448',
      'Fire Tonic' => '#d74e0f',
      'Ice Tonic' => '#6f92b7',
      'Thunder Tonic' => '#e1ce36',
      'Shadow Tonic' => '#4c3f90',
      'Radiation Tonic' => '#435115',
      'Sight Enhancer' => '#61abc5',
      'Alertness Enhancer' => '#bcb69d',
      'Insight Enhancer' => '#9270b3',
      'Dowsing Enhancer' => '#518c4a',
      'Seeking Enhancer' => '#d2686b',
      'Poison Cure' => '#5c356d',
      'Drowsiness Cure' => '#3c7d79',
      'Petrification Cure' => '#54554e',
      'Silence Cure' => '#d75360',
      'Curse Cure' => '#393b6b'
    }[object.name]
  end
end
