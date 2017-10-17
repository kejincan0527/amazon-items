Rails.application.routes.draw do
  root 'main#index'

  get 'main/index'

  get 'main/brand/:brand_id', to: 'main#brand'

  get 'main/search'

  get 'main/detail'

  resources :items
  resources :brands
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
