class RecipeDecorator < ApplicationDecorator
  decorates :recipe
  include Draper::LazyHelpers

  def display_rarity
    %w[Minor Common Greater Grand Superior Masterwork][object.rarity]
  end
end
