require 'rails_helper'

RSpec.describe CupboardIngredientDecorator do
  context 'methods' do
    context '#display_quinn_tab' do
      it 'returns 1 when quinn_location is 0' do
        cupboard_ingredient = create(:cupboard_ingredient, quinn_location: 0)
        expect(cupboard_ingredient.display_quinn_tab).to eq(1)
      end

      it 'returns 1 when quinn_location is 9' do
        cupboard_ingredient = create(:cupboard_ingredient, quinn_location: 9)
        expect(cupboard_ingredient.display_quinn_tab).to eq(1)
      end

      it 'returns 2 when quinn_location is 10' do
        cupboard_ingredient = create(:cupboard_ingredient, quinn_location: 10)
        expect(cupboard_ingredient.display_quinn_tab).to eq(2)
      end

      it 'returns 16 when quinn_location is 159' do
        cupboard_ingredient = create(:cupboard_ingredient, quinn_location: 159)
        expect(cupboard_ingredient.display_quinn_tab).to eq(16)
      end

      it 'returns 17 when quinn_location is 160' do
        cupboard_ingredient = create(:cupboard_ingredient, quinn_location: 160)
        expect(cupboard_ingredient.display_quinn_tab).to eq(17)
      end
    end

    context '#display_quinn_slot' do
      it 'returns 1 when quinn_location is 0' do
        cupboard_ingredient = create(:cupboard_ingredient, quinn_location: 0)
        expect(cupboard_ingredient.display_quinn_slot).to eq(1)
      end

      it 'returns 10 when quinn_location is 9' do
        cupboard_ingredient = create(:cupboard_ingredient, quinn_location: 9)
        expect(cupboard_ingredient.display_quinn_slot).to eq(10)
      end

      it 'returns 1 when quinn_location is 10' do
        cupboard_ingredient = create(:cupboard_ingredient, quinn_location: 10)
        expect(cupboard_ingredient.display_quinn_slot).to eq(1)
      end

      it 'returns 7 when quinn_location is 159' do
        cupboard_ingredient = create(:cupboard_ingredient, quinn_location: 159)
        expect(cupboard_ingredient.display_quinn_slot).to eq(10)
      end

      it 'returns 10 when quinn_location is 160' do
        cupboard_ingredient = create(:cupboard_ingredient, quinn_location: 160)
        expect(cupboard_ingredient.display_quinn_slot).to eq(1)
      end
    end
  end
end
