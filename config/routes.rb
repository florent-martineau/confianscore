Rails.application.routes.draw do
  resources :messages
  devise_for :users
  get 'users/:id' => 'users#show'
  resources :commentaires
  resources :searches
  #resources :scores
  #resources :point_verites
  resources :tags
  resources :votes
  resources :sources
  get 'people/:id/image' => 'people#image'
  resources :people
  root to: 'main#index'
  get '/charte' => 'main#charte', as: 'charte'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
