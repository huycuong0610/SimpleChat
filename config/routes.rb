Rails.application.routes.draw do
  get 'friend_ship/create'

  get 'friend_ship/destroy'
  get 'users/block'
  get 'users/unblock'

  resources :sessions, only: [:new, :create]
  resources :users do
  	resources :messages
  end
  get 'auth/:provider/callback' => 'sessions#callback'
  get 'auth/failure', to: redirect('/')
  get '/logout' => 'sessions#destroy'
  get '/message/show' =>'messages#show'
  get '/show' => 'users#show'
  get '/sent' => 'users#sent'
  get '/friends'	=> 'users#all_user'
  root "users#index"
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
