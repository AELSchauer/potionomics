module RecipeOptimizations
  class AdvancedFiltersController < ApplicationController
    include CupboardConcern
    include FilterRecipesConcern

    def index
      session['filter']['advanced'] = [] if session['filter']['advanced'].blank?
      @filters = session['filter']['advanced']
      @filter = {}
    end

    def create
      @filter = { 'id' => session['filter']['advanced'].count + 1, **advanced_filter_params.to_h }

      if advanced_filter_params.values.all?(&:present?)
        session['filter']['advanced'] << @filter

        respond_to do |format|
          format.html { redirect_to cupboard_recipe_optimizations_advanced_filters_path(@current_cupboard) }
          format.turbo_stream
        end
      else
        @error_message = 'Value cannot be blank.'
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @filter = session['filter']['advanced'].find { |obj| obj['id'].to_s == params[:id] }
    end

    def destroy
      @filter = { 'id' => params[:id] }
      session['filter']['advanced'].delete_if { |obj| obj['id'].to_s == params[:id] }

      respond_to do |format|
        format.html { redirect_to cupboard_recipe_optimizations_advanced_filters_path(@current_cupboard) }
        format.turbo_stream
      end
    end

    private

    def advanced_filter_params
      params[:filter][:advanced].permit!
    end
  end
end
