module FilterRecipesConcern
  extend ActiveSupport::Concern
  
  def get_recipe_optimizations
    if params[:tab].blank? || params[:tab] == "all_recipes"
      @recipe_optimizations = RecipeOptimization.where(cupboard: @cupboard)
    elsif params[:tab] == "ready_to_brew" 
      @recipe_optimizations = RecipeOptimization.where(cupboard: @cupboard).ready_to_brew
    elsif params[:tab] == "purchasable_ingredients" 
      @recipe_optimizations = RecipeOptimization.where(cupboard: @cupboard).purchasable
    elsif params[:tab] == "missing_ingredients" 
      @recipe_optimizations = RecipeOptimization.where(cupboard: @cupboard).undiscovered
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
      @recipe_optimizations = @recipe_optimizations.where("#{advanced_filter["attribute"]} #{advanced_filter["operator"]} ?", advanced_filter["value"])
    end
  end

  def filter_by_name
    filter_names = session["filter"]["name"].keys.map(&:titleize)
    filter_recipe_type_ids = RecipeType.where(name: filter_names)
    @recipe_optimizations = @recipe_optimizations.where(recipe_type_id: filter_recipe_type_ids)
  end

  def filter_by_num_of_ingredients
    filter_num_of_ingredients = session["filter"]["num_of_ingredients"].keys
    @recipe_optimizations = @recipe_optimizations.where(num_of_ingredients: filter_num_of_ingredients)
  end

  def filter_by_num_of_potions
    filter_num_of_potions = session["filter"]["num_of_potions"].keys
    @recipe_optimizations = @recipe_optimizations.where(num_of_potions: filter_num_of_potions)
  end

  def filter_by_rarity
    filter_rarity = session["filter"]["rarity"].keys
    @recipe_optimizations = @recipe_optimizations.where(rarity: filter_rarity)
  end

  def filter_by_stars
    filter_stars = session["filter"]["stars"].keys
    @recipe_optimizations = @recipe_optimizations.where(stars: filter_stars)
  end
  
  def paginate_recipes
    @recipe_optimizations = Kaminari.paginate_array(@recipe_optimizations).page(params[:page]).per(25)
  end
end
