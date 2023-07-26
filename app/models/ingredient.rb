class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :cupboard_ingredients

  validates :name, presence: true, uniqueness: true

  before_save do
    self.total_magimins = a_magimins + b_magimins + c_magimins + d_magimins + e_magimins
  end
end
