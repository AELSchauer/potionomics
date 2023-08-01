class CupboardIngredientsController < ApplicationController
  include CupboardConcern
  before_action :current_cupboard_ingredient, only: [:edit, :update, :destroy]

  def index
    cupboard_ingredients = @cupboard.cupboard_ingredients.joins(:ingredient)
    if params[:sort] == "quinn"
      @quinn_ingredients = cupboard_ingredients.where.not(quantity: 0, quinn_location: 0).order(quinn_location: :asc)
      @cupboard_ingredients = cupboard_ingredients.where.not(quantity: 0).where(quinn_location: 0)
    else 
      @cupboard_ingredients = cupboard_ingredients.order(name: :asc)
    end
  end

  def new
    undiscovered_ingredient_ids =  @cupboard.cupboard_ingredients.where(quantity: 0, quinn_location: 0).pluck(:ingredient_id)
    @ingredients = Ingredient.where(id: undiscovered_ingredient_ids).order(name: :asc)
  end

  def create
    @cupboard_ingredient = CupboardIngredient.new(cupboard_ingredient_params)
    if params[:quinn_stock] == "1"
      last_location = @cupboard.cupboard_ingredients.sort(:quinn_location).last.quinn_location
      @cupboard_ingredient.assign_attributes(quinn_location: last_location + 1)
    end

    if @cupboard_ingredient.save
      redirect_to cupboard_cupboard_ingredients_path(@cupboard)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end

  def update
    if @cupboard_ingredient.update(cupboard_ingredient_params)
      redirect_to cupboard_cupboard_ingredients_path(@cupboard)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def current_cupboard_ingredient
    @cupboard_ingredient = @cupboard.cupboard_ingredients.find(params[:id])
  end

  def cupboard_ingredient_params
    params.require(:cupboard_ingredient).permit(:ingredient_id, :quantity, :cupboard_id)
  end
end
