Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'
  resources :cupboards, only: %i[index new create destroy] do
    resources :brew_recipes, only: %i[create update destroy]
    resources :cupboard_ingredients, only: %i[index new create edit update]
    resources :favorite_recipes, only: %i[create destroy]
    resources :recipe_optimizations, only: [:index]
    namespace :recipe_optimizations do
      resources :advanced_filters, only: %i[index new create show destroy]
      resources :ingredient_filters, only: %i[index new create show destroy]
      resources :filters, only: %i[show update] do
        delete 'reset', on: :collection
      end
    end
  end

  devise_for :users
end
