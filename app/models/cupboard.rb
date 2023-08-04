class Cupboard < ApplicationRecord
  has_many :cupboard_ingredients
  has_many :ingredients, through: :cupboard_ingredients
  has_many :cupboard_cauldrons
  has_many :cauldrons, through: :cupboard_cauldrons
  has_many :recipe_optimizations
  has_many :favorite_recipes
  has_many :brew_recipes
  belongs_to :user

  after_create do
    Ingredient.all.each do |ingredient|
      CupboardIngredient.create(cupboard: self, ingredient:)
    end
  end
end
