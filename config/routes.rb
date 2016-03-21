Rails.application.routes.draw do
  resources :personnels

  get "password_resets/new"
  get 'current_user' => "personnels#current_user"
  get "sessions/new"

  get "log_out" => 'sessions#destroy', :as => "log_out"
  get "log_in" => 'sessions#new', :as => "log_in"
  get "sign_up" => 'personnels#new', :as => "sign_up"
  root :to => 'personnels#new'
  resources :sessions
  resources :password_resets

end
