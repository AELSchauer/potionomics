class RecipeOptimizations::AdvancedFiltersController < ApplicationController
  include CupboardConcern
  include FilterRecipesConcern

  def index
    session["filter"]["advanced"] = [] if session["filter"]["advanced"].blank?
    @filters = session["filter"]["advanced"]
  end

  def create
    @filter = {"id" => session["filter"]["advanced"].count + 1 }
    session["filter"]["advanced"] << @filter.to_h
  
    respond_to do |format|
      format.html { redirect_to cupboard_recipe_optimizations_advanced_filters_path(@cupboard) }
      format.turbo_stream
    end
  end

  def destroy
    @filter = { "id" => params[:id] }
    session["filter"]["advanced"].delete_if { |obj| obj["id"].to_s == params[:id] }

    respond_to do |format|
      format.html { redirect_to cupboard_recipe_optimizations_advanced_filters_path(@cupboard) }
      format.turbo_stream
    end
  end
end
