class RecipeOptimizationsController < ApplicationController
  include CupboardHelper
  before_action :set_cupboard, only: [:index, :show]
  
  def index
    get_recipes
    get_heatmaps
    paginate_recipes
  end

  private

  def get_recipes
    @recipes = Recipe.ready_to_make(cupboard: @cupboard)
  end

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

  def paginate_recipes
    @recipes = Kaminari.paginate_array(@recipes).page(params[:page]).per(100)
  end
end
