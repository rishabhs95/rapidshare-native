Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'upload#index'
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/users/update/:user_id' => 'users#show'
  patch 'users/update/:user_id' => 'users#update'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :upload
end
