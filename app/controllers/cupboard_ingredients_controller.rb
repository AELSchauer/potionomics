class CupboardIngredientsController < ApplicationController
  include CupboardConcern

  def index
    @cupboard_ingredients = @cupboard.cupboard_ingredients.where(discovered: true).joins(:ingredient)
  end

  def new
    @ingredients = Ingredient.joins(:cupboard_ingredients).where(cupboard_ingredients: { cupboard: @cupboard, discovered: false })
    @cupboard_ingredient = @cupboard.cupboard_ingredients.first
  end

  def create
    @cupboard_ingredient = @cupboard.cupboard_ingredients.find_by(ingredient_id: params[:ingredient_id])

    @cupboard_ingredient.assign_attributes(quantity: params[:quantity], discovered: true)
    if params[:quinn_stock]
      @cupboard_ingredient.assign_attributes(quinn_location: @cupboard.cupboard_ingredients.pluck(:quinn_location).compact.max + 1)
    end
    
    if @cupboard_ingredient.save
      redirect_to cupboard_cupboard_ingredients_path(@cupboard, params[:tab] ? { tab: params[:tab] } : {})
    else
      @ingredients = Ingredient.joins(:cupboard_ingredients).where(cupboard_ingredients: { cupboard: @cupboard, discovered: false })
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @cupboard_ingredient = @cupboard.cupboard_ingredients.find(params[:id])
  end

  def update
    @cupboard_ingredient = @cupboard.cupboard_ingredients.find(params[:id])

    if @cupboard_ingredient.update(quantity: params[:quantity])
      redirect_to cupboard_cupboard_ingredients_path(@cupboard)
    else
      render :edit, status: :unprocessable_entity
    end
  end
end
