class CupboardIngredientsController < ApplicationController
  include CupboardConcern

  def index
    @cupboard_ingredients = @cupboard.cupboard_ingredients.where(discovered: true).joins(:ingredient)
  end
end
