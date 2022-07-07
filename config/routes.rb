Rails.application.routes.draw do
  # resources :services
  resources :users
  resources :categories, shallow: true do
    resources :services
  end
  resources :orders
  get 'pages/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#index"
end
