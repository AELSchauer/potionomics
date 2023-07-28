class RecipeOptimizations::AdvancedFiltersController < ApplicationController
  include CupboardConcern
  include FilterRecipesConcern

  def index
    convert_params_to_session
    @filters = session["filter"]
  end

  def create
    @filter = {"id" => session["filter"].count + 1 }
    session["filter"] << @filter.to_h
  
    respond_to do |format|
      format.html { redirect_to cupboard_recipe_optimizations_advanced_filters_path(@cupboard) }
      format.turbo_stream
    end
  end

  def destroy
    @filter = { "id" => params[:id] }
    session["filter"].delete_if { |obj| obj["id"].to_s == params[:id] }

    respond_to do |format|
      format.html { redirect_to cupboard_recipe_optimizations_advanced_filters_path(@cupboard) }
      format.turbo_stream
    end
  end

  private

  def convert_params_to_session
    filter_params

    if session["filter"].blank?
      if params.dig(:filter, :advanced).present?
        session["filter"] = params[:filter][:advanced].each_with_index.map { |obj, idx| { "id" => idx + 1, **obj.to_h }}
        params[:filter].delete(:advanced)
      else
        session["filter"] = []
      end
    end
  end
end
