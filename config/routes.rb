Rails.application.routes.draw do
  root "orders#index"
  get 'line_items/new'
  get 'line_items/create'
  # resources :services
  resources :users
  resources :categories, shallow: true do
    resources :services
  end
  resources :orders, shallow: true do
    resources :line_items, only: %i[new edit create update destroy]
  end
  get 'pages/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
