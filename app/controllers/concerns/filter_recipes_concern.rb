module FilterRecipesConcern
  extend ActiveSupport::Concern

  def get_recipes
    @recipes = Recipe.ready_to_make(cupboard: @cupboard)
  end

  def paginate_recipes
    @recipes = Kaminari.paginate_array(@recipes).page(params[:page]).per(100)
  end
end