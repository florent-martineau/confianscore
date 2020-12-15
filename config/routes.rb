Rails.application.routes.draw do
  resources :scores
  resources :point_verites
  resources :tags
  resources :votes
  resources :sources
  resources :people
  root to: 'main#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
