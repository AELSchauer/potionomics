class CreateCupboardCauldrons < ActiveRecord::Migration[6.1]
  def change
    create_table :cupboard_cauldrons do |t|
      t.references :cupboard, null: false, foreign_key: true
      t.references :cauldron, null: false, foreign_key: true
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
