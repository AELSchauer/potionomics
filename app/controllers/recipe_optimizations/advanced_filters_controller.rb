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
      format.html { redirect_to filters_path, notice: "Quote was successfully created." }
      format.turbo_stream
    end
  end

  def destroy
    @filter = Filter.new(params[:id])
    session["filter"].delete_if { |obj| obj["id"].to_s == params[:id] }

    respond_to do |format|
      format.html { redirect_to filters_path, notice: "Quote was successfully destroyed." }
      format.turbo_stream
    end
  end
end
