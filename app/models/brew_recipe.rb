class BrewRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :cupboard
end
