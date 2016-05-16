Rails.application.routes.draw do
  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'contact' => 'static_pages#contact'
  get 'about' => 'static_pages#about'
  get 'login'  => 'users#new'
  get '/auth/callback' => 'users#create'
  delete 'logout'  => 'users#destroy'

  resources :users
  resources :squads

  scope '/api' do
    scope '/v1' do
      scope 'user' do
        get '/squadrun' => 'order#index'
      end
    end
  end
end
