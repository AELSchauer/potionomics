class RemoveQuinnLocationTabAndQuinnLocationSlotFromCupboardIngredients < ActiveRecord::Migration[7.0]
  def change
    remove_column :cupboard_ingredients, :quinn_location_tab, :integer
    remove_column :cupboard_ingredients, :quinn_location_slot, :integer
  end
end
