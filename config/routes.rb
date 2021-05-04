Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :counters
  root to: 'start#index'
  get '/last-counters', to: 'flats#last_flat_counters'
  get '/debtor-list', to: 'flats#debtor_list'
  resources :flats
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
