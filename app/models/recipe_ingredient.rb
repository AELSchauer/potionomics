class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :recipe, uniqueness: { scope: :ingredient }

  def a_magimins
    ingredient.a_magimins * quantity
  end

  def b_magimins
    ingredient.b_magimins * quantity
  end

  def c_magimins
    ingredient.c_magimins * quantity
  end

  def d_magimins
    ingredient.d_magimins * quantity
  end

  def e_magimins
    ingredient.e_magimins * quantity
  end

  def total_magimins
    a_magimins + b_magimins + c_magimins + d_magimins + e_magimins
  end

  def total_cost
    ingredient.base_price * quantity
  end
end
