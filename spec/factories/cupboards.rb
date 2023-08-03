FactoryBot.define do
  factory :cupboard do
    user { create(:user) }
  end
end
