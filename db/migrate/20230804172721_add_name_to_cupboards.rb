class AddNameToCupboards < ActiveRecord::Migration[7.0]
  def change
    add_column :cupboards, :name, :string, required: true
  end
end
