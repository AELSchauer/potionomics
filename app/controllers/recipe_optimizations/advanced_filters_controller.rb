class RecipeOptimizations::AdvancedFiltersController < ApplicationController
  include CupboardConcern
  Filter = Struct.new(:id)

  def index
    session["filter"] = [] if session["filter"].nil?
    @filters = session["filter"].map { |obj| Filter.new(obj["id"]) }
  end

  def create
    @filter = Filter.new(session["filter"].count + 1)
    session["filter"] << @filter.to_h
  
    respond_to do |format|
      format.html { redirect_to cupboard_recipe_optimizations_advanced_filters_path(@cupboard) }
      format.turbo_stream
    end
  end

  def destroy
    @filter = Filter.new(params[:id])
    session["filter"].delete_if { |obj| obj["id"].to_s == params[:id] }

    respond_to do |format|
      format.html { redirect_to cupboard_recipe_optimizations_advanced_filters_path(@cupboard) }
      format.turbo_stream
    end
  end
end
