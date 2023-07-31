class RecipeOptimizationsController < ApplicationController
  include CupboardConcern
  include FilterRecipesConcern
  
  def index
    session["filter"] = {} if session["filter"].empty?
    get_recipe_optimizations
    filter_recipes
    get_heatmaps
    sort_recipes
    paginate_recipes
  end

  private

  def get_heatmaps
    @heatmaps = [
        :cost_per_potion,
        :cost,
        :num_of_ingredients,
        :num_of_potions,
        :profit_margin,
        :profit_margin_per_potion,
        :profit,
        :stars,
        :total_magimins
      ].map do |attr_name|
        arr = @recipe_optimizations.pluck(attr_name)
        [attr_name, [arr.max, arr.min]]
      end.to_h
  end

  def sort_recipes
    if params[:sort].present? && params[:sort].include?("name")
      @recipe_optimizations = @recipe_optimizations.includes(:recipe_type).order(params[:sort].sub("name", "recipe_types.sort_order"))
    else
      @recipe_optimizations = @recipe_optimizations.order(params[:sort])
    end
  end
end
