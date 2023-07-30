module FilterRecipesConcern
  extend ActiveSupport::Concern
  
  def get_recipes
    if params[:tab].blank? || params[:tab] == "all_recipes"
      @recipes = Recipe.all
    elsif params[:tab] == "ready_to_brew" 
      @recipes = Recipe.ready_to_brew(cupboard: @cupboard)
    elsif params[:tab] == "purchasable_ingredients" 
      @recipes = Recipe.with_purchasable_ingredients(cupboard: @cupboard)
    elsif params[:tab] == "missing_ingredients" 
      @recipes = Recipe.with_missing_ingredients(cupboard: @cupboard)
    end
  end

  def filter_recipes
    filter_advanced if session.dig("filter", "advanced")
    filter_by_name if session.dig("filter", "name")
    filter_by_num_of_potions if session.dig("filter", "num_of_potions")
    filter_by_num_of_ingredients if session.dig("filter", "num_of_ingredients")
    filter_by_rarity if session.dig("filter", "rarity")
    filter_by_stars if session.dig("filter", "stars")
  end
  
  def filter_advanced
    session["filter"]["advanced"].each do |advanced_filter|
      @recipes = @recipes.where("#{advanced_filter["attribute"]} #{advanced_filter["operator"]} ?", advanced_filter["value"])
    end
  end

  def filter_by_name
    filter_names = session["filter"]["name"].keys.map(&:titleize)
    filter_recipe_type_ids = RecipeType.where(name: filter_names)
    @recipes = @recipes.where(recipe_type_id: filter_recipe_type_ids)
  end

  def filter_by_num_of_ingredients
    filter_num_of_ingredients = session["filter"]["num_of_ingredients"].keys
    @recipes = @recipes.where(num_of_ingredients: filter_num_of_ingredients)
  end

  def filter_by_num_of_potions
    filter_num_of_potions = session["filter"]["num_of_potions"].keys
    @recipes = @recipes.where(num_of_potions: filter_num_of_potions)
  end

  def filter_by_rarity
    filter_rarity = session["filter"]["rarity"].keys
    @recipes = @recipes.where(rarity: filter_rarity)
  end

  def filter_by_stars
    filter_stars = session["filter"]["stars"].keys
    @recipes = @recipes.where(stars: filter_stars)
  end
  
  def paginate_recipes
    @recipes = Kaminari.paginate_array(@recipes).page(params[:page]).per(25)
  end
end