class CreateCupboards < ActiveRecord::Migration[6.1]
  def change
    create_table :cupboards do |t|
      t.integer :highest_license_tier, default: 1

      t.timestamps
    end
  end
end
