class CupboardIngredientsController < ApplicationController
  include CupboardConcern

  def index
    @cupboard_ingredients = @cupboard.cupboard_ingredients.where(discovered: true).joins(:ingredient)
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
