class RecipeOptimizationsController < ApplicationController
  include CupboardConcern
  include FilterRecipesConcern
  
  def index
    session["filter"] = {} if session["filter"].empty?
    get_recipes
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
        :profit_ratio,
        :profit,
        :stars,
        :total_magimins
      ].map do |attr_name|
        arr = @recipes.pluck(attr_name)
        [attr_name, [arr.max, arr.min]]
      end.to_h
  end

  def sort_recipes
    if params[:sort].include?("name")
      @recipes = @recipes.includes(:recipe_type).order(params[:sort].sub("name", "recipe_types.sort_order"))
    else
      @recipes = @recipes.order(params[:sort])
    end
  end
end
