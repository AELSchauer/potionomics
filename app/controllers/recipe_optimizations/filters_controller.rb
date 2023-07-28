class RecipeOptimizations::FiltersController < ApplicationController
  include CupboardConcern
  include FilterRecipesConcern

  def show
    get_recipes
  end
end