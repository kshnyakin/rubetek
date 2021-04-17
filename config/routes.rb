Rails.application.routes.draw do
  root to: 'start#index'
  resources :flats
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
