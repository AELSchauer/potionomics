class RecipeOptimizations::FiltersController < ApplicationController
  include CupboardConcern
  include FilterRecipesConcern

  def reset
    session["filter"] = {}
    redirect_to cupboard_recipe_optimizations_path(@cupboard.id)
  end

  def show
    session["filter"] = {} if session["filter"].blank?
    get_recipes
  end

  def update
    session["filter"][params[:id]] = params[:filter][params[:id]]
    redirect_to cupboard_recipe_optimizations_path(@cupboard.id)
  end
end