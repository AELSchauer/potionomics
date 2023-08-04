module RecipeOptimizations
  class FiltersController < ApplicationController
    include CupboardConcern
    include FilterRecipesConcern

    def reset
      session['filter'] = {}
      redirect_to cupboard_recipe_optimizations_path(@current_cupboard.id)
    end

    def show
      session['filter'] = {} if session['filter'].blank?
      load_recipe_optimizations
    end

    def update
      session['filter'][params[:id]] = params[:filter][params[:id]]
      redirect_to cupboard_recipe_optimizations_path(@current_cupboard.id)
    end
  end
end
