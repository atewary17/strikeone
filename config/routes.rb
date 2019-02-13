Rails.application.routes.draw do
  resources :personnels

  get "password_resets/new"
  get 'current_user' => "personnels#current_user"
  get "sessions/new"

  get "log_out" => 'sessions#destroy', :as => "log_out"
  get "log_in" => 'sessions#new', :as => "log_in"
  get "sign_up" => 'personnels#new', :as => "sign_up"
  root :to => 'sessions#new'
  resources :sessions
  resources :password_resets

  # resources :personnels do
  #   collection do
  #     match 'search' => 'personnels#search', via: [:get, :post], as: :search
  #   end
  # end

  # resources :labels, only: :index do
  #   match 'search' => 'labels#search',
  #         on: :collection, via: [:get, :post], as: :advanced_search
  # end

  get "windows/index"

  get "windows/upload_image"
  post "windows/upload_image"

  get "windows/image_upload"
  post "windows/image_upload"

  get "windows/upload_register"
  post "windows/upload_register"

  get "windows/process_image"
  post "windows/process_image"

  get "windows/processed_images"
  post "windows/processed_images"

  get "windows/unprocessed_uploads"
  post "windows/unprocessed_uploads"

  get "windows/search_index"
  post "windows/search_index"

  get "windows/search"
  post "windows/search"

  get "windows/autocomplete_label"
  post "windows/autocomplete_label"
  
end
