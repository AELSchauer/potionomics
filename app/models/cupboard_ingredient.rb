class CupboardIngredient < ApplicationRecord
  belongs_to :cupboard
  belongs_to :ingredient

  validates :cupboard, uniqueness: { scope: :ingredient }
  validates :quantity, numericality: { greater_than: -1 }

  after_save do
    cupboard.update(updated_at: self.updated_at)
  end
end
