module FilterRecipesConcern
  extend ActiveSupport::Concern
  
  def get_recipes
    @recipes = Recipe.ready_to_make(cupboard: @cupboard)
  end

  def filter_params
    params.dig(:filter).try(:permit!)
    params.dig(:filter, :name).try(:permit!)
    params.dig(:filter, :num_of_ingredients).try(:permit!)
    params.dig(:filter, :num_of_potions).try(:permit!)
    params.dig(:filter, :rarity).try(:permit!)
    params.dig(:filter, :stars).try(:permit!)
  end

  def filter_recipes
    filter_params

    filter_by_name if params.dig(:filter, :name)
    filter_by_num_of_potions if params.dig(:filter, :num_of_potions)
    filter_by_num_of_ingredients if params.dig(:filter, :num_of_ingredients)
    filter_by_rarity if params.dig(:filter, :rarity)
    filter_by_stars if params.dig(:filter, :stars)
  end
  
  def filter_by_name
    filter_names = params[:filter][:name].keys.map(&:titleize)
    filter_recipe_type_ids = RecipeType.where(name: filter_names)
    @recipes = @recipes.where(recipe_type_id: filter_recipe_type_ids)
  end

  def filter_by_num_of_ingredients
    filter_num_of_ingredients = params[:filter][:num_of_ingredients].keys
    @recipes = @recipes.where(num_of_ingredients: filter_num_of_ingredients)
  end

  def filter_by_num_of_potions
    filter_num_of_potions = params[:filter][:num_of_potions].keys
    @recipes = @recipes.where(num_of_potions: filter_num_of_potions)
  end

  def filter_by_rarity
    filter_rarity = params[:filter][:rarity].keys
    @recipes = @recipes.where(rarity: filter_rarity)
  end

  def filter_by_stars
    filter_stars = params[:filter][:stars].keys
    @recipes = @recipes.where(stars: filter_stars)
  end
  
  def paginate_recipes
    @recipes = Kaminari.paginate_array(@recipes).page(params[:page]).per(100)
  end
end