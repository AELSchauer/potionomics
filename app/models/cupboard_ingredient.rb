class CupboardIngredient < ApplicationRecord
  belongs_to :cupboard
  belongs_to :ingredient

  validates :ingredient, uniqueness: { scope: :cupboard, message: 'already exists in this cupboard' }
  validates :quantity, presence: true, numericality: { greater_than: -1 }

  delegate  :display_quinn_slot, :display_quinn_tab, to: :decorator

  def decorator
    CupboardIngredientDecorator.new(self)
  end
end
