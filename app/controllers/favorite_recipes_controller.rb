class FavoriteRecipesController < ApplicationController
  def create
    FavoriteRecipe.create(cupboard_id: params[:cupboard_id], recipe_id: params[:id])
    redirect_to cupboard_recipe_optimizations_path(params[:cupboard_id])
  end
  
  def destroy
    FavoriteRecipe.find_by(cupboard_id: params[:cupboard_id], recipe_id: params[:id]).destroy
    redirect_to cupboard_recipe_optimizations_path(params[:cupboard_id])
  end
end
