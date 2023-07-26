class AddSortOrderToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :sort_order, :integer
  end
end
