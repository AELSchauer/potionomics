FactoryBot.define do
  factory :cupboard_ingredient do
    cupboard { create(:cupboard) }
    ingredient { create(:ingredient) }
    quantity { 0 }
    quinn_location { 0 }
    discovered { false }
  end
end
