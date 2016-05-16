Rails.application.routes.draw do
  # get 'users_controller/create'
  #
  # get 'users_controller/destroy'

  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'contact' => 'static_pages#contact'
  get 'about' => 'static_pages#about'
  get 'login'  => 'users#new'
  get '/auth/callback' => 'users#create'
  delete 'logout'  => 'users#destroy'

  resources :users
end
