class CupboardIngredientDecorator < ApplicationDecorator
  decorates :cupboard_ingredient
  include Draper::LazyHelpers

  def display_quinn_slot
    return nil if object.quinn_location.nil?

    (object.quinn_location % 10) + 1
  end

  def display_quinn_tab
    return nil if object.quinn_location.nil?

    (object.quinn_location + 10) / 10
  end
end
