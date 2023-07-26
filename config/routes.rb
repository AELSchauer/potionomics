Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  resources :cupboards, only: [:index, :new, :create, :destroy] do 
    resources :recipe_optimizations, only: [:index] do
      collection do
        get "filter/:attr", to: "recipe_optimizations/filter#show", as: "filter"
      end
    end
    resources :favorite_recipes, only: [:create, :destroy]
    resources :brew_recipes, only: [:create, :update, :destroy]
  end
  devise_for :users
end
