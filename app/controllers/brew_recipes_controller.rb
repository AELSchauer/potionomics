class BrewRecipesController < ApplicationController
  def create
    BrewRecipe.create(cupboard_id: params[:cupboard_id], recipe_id: params[:id])
    redirect_to cupboard_recipe_optimizations_path(params[:cupboard_id])
  end

  def update
    Recipe.find(params[:id]).recipe_ingredients.pluck(:ingredient_id, :quantity).each do |ingredient_id, quantity|
      ci = CupboardIngredient.find_by(ingredient_id: ingredient_id, cupboard_id: params[:cupboard_id])
      ci.update(quantity: ci.quantity - quantity)
    end
    redirect_to cupboard_recipe_optimizations_path(params[:cupboard_id])
  end
  
  def destroy
    BrewRecipe.find_by(cupboard_id: params[:cupboard_id], recipe_id: params[:id]).destroy
    redirect_to cupboard_recipe_optimizations_path(params[:cupboard_id])
  end
end
