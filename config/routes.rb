Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  devise_for :users

  resources :cupboards, only: [:index, :new, :create, :destroy] do 
    resources :brew_recipes, only: [:create, :update, :destroy]
    resources :cupboard_ingredients, only: [:index, :new, :create, :edit, :update]
    resources :favorite_recipes, only: [:create, :destroy]
    resources :recipe_optimizations, only: [:index]
    namespace :recipe_optimizations do
      resources :advanced_filters, only: [:index, :new, :create, :show, :destroy]
      resources :filters, only: [:show, :update] do
        delete "reset", on: :collection
      end
    end
  end
end
