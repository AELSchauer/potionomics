module RecipeOptimizations
  class IngredientFiltersController < ApplicationController
    include CupboardConcern
    include FilterRecipesConcern

    def index
      session['filter']['ingredient'] = [] if session['filter']['ingredient'].blank?
      @filters = session['filter']['ingredient']
      @filter = {}
    end

    def create
      @filter = { 'id' => session['filter']['ingredient'].count + 1, **ingredient_filter_params.to_h }

      if ingredient_filter_params.values.all?(&:present?)
        session['filter']['ingredient'] << @filter

        respond_to do |format|
          format.html { redirect_to cupboard_recipe_optimizations_ingredient_filters_path(@current_cupboard) }
          format.turbo_stream
        end
      else
        @error_message = 'Value cannot be blank.'
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @filter = session['filter']['ingredient'].find { |obj| obj['id'].to_s == params[:id] }
    end

    def destroy
      @filter = { 'id' => params[:id] }
      session['filter']['ingredient'].delete_if { |obj| obj['id'].to_s == params[:id] }

      respond_to do |format|
        format.html { redirect_to cupboard_recipe_optimizations_ingredient_filters_path(@current_cupboard) }
        format.turbo_stream
      end
    end

    private

    def ingredient_filter_params
      params[:filter][:ingredient].permit!
    end
  end
end
