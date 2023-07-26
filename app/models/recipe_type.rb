class RecipeType < ApplicationRecord
  has_many :recipes

  def grouping
    sort_order.floor
  end
end
