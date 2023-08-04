FactoryBot.define do
  factory :ingredient do
    name { "#{Faker::Color.color_name.capitalize} #{Faker::Food.fruits.singularize}" }
    rarity { 1 }
    category { 'Fruit' }
    location { 'Enchanted Forest' }
    base_price { 20 }
    a_magimins { 3 }
    b_magimins { 3 }
    c_magimins { 3 }
    d_magimins { 3 }
    e_magimins { 3 }
    total_magimins { a_magimins + b_magimins + c_magimins + d_magimins + e_magimins }
    taste_val { 0 }
    touch_val { 0 }
    smell_val { 0 }
    sight_val { 0 }
    sound_val { 0 }
  end
end
