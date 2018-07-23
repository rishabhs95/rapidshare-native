Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'upload#index'
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/user' => 'users#show'
  get '/user/edit' => 'users#edit'
  patch '/user/update' => 'users#update'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/download' => 'upload#_show'

  resources :upload
end
