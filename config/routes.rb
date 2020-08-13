Rails.application.routes.draw do
  # get 'properties/index'
  # get 'properties/show'
  resources :properties, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
