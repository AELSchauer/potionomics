class CupboardIngredientsController < ApplicationController
  include CupboardConcern

  def index
    @cupboard_ingredients = @current_cupboard.cupboard_ingredients.where(discovered: true).joins(:ingredient)
  end

  def new
    @ingredients = Ingredient.joins(:cupboard_ingredients)
                             .where(cupboard_ingredients: { cupboard: @current_cupboard, discovered: false })
    @cupboard_ingredient = @current_cupboard.cupboard_ingredients.first
  end

  def create
    @cupboard_ingredient = @current_cupboard.cupboard_ingredients.find_by(ingredient_id: params[:ingredient_id])

    @cupboard_ingredient.assign_attributes(quantity: params[:quantity], discovered: true)
    if params[:quinn_stock]
      quinn_location = @current_cupboard.cupboard_ingredients.pluck(:quinn_location).compact.max + 1
      @cupboard_ingredient.assign_attributes(quinn_location:)
    end

    if @cupboard_ingredient.save
      redirect_to cupboard_cupboard_ingredients_path(@current_cupboard, params[:tab] ? { tab: params[:tab] } : {})
    else
      @ingredients = Ingredient.joins(:cupboard_ingredients)
                               .where(cupboard_ingredients: { cupboard: @current_cupboard, discovered: false })
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @cupboard_ingredient = @current_cupboard.cupboard_ingredients.find(params[:id])
  end

  def update
    @cupboard_ingredient = @current_cupboard.cupboard_ingredients.find(params[:id])

    if @cupboard_ingredient.update(quantity: params[:quantity])
      redirect_to cupboard_cupboard_ingredients_path(@current_cupboard)
    else
      render :edit, status: :unprocessable_entity
    end
  end
end
