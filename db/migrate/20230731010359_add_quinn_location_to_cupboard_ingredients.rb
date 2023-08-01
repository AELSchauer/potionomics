class AddQuinnLocationToCupboardIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :cupboard_ingredients, :quinn_location, :integer, default: 0
  end
end

