class RecipeOptimizationsController < ApplicationController
  include CupboardConcern
  include FilterRecipesConcern

  def index
    session['filter'] = {} unless session['filter'].present?
    load_recipe_optimizations
    filter_recipes
    load_heatmaps
    sort_recipes
    paginate_recipes
  end

  private

  def load_heatmaps
    @heatmaps = %i[
      cost_per_potion
      cost
      num_of_ingredients
      num_of_potions
      profit_margin
      profit_margin_per_potion
      profit
      stars
      total_magimins
    ].map do |attr_name|
      arr = @recipe_optimizations.pluck(attr_name)
      [attr_name, [arr.max, arr.min]]
    end.to_h
  end

  def sort_recipes
    @recipe_optimizations = if params[:sort].present? && params[:sort].include?('name')
                              @recipe_optimizations.includes(:recipe_type)
                                                   .order(params[:sort]
                                                   .sub('name', 'recipe_types.sort_order'))
                            else
                              @recipe_optimizations.order(params[:sort])
                            end
  end
end
