class CreateCauldrons < ActiveRecord::Migration[6.1]
  def change
    create_table :cauldrons do |t|
      t.string :name
      t.integer :tier
      t.integer :max_ingredients
      t.integer :max_magimins
      t.references :upgrade, foreign_key: { to_table: :cauldrons }

      t.timestamps
    end
  end
end
