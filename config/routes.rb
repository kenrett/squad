Rails.application.routes.draw do
  root 'static_pages#home'

  get 'order/index'
  get 'get_ride' => 'order#new'
  get 'help' => 'static_pages#help'
  get 'contact' => 'static_pages#contact'
  get 'about' => 'static_pages#about'
  get 'login' => 'users#new'
  get '/auth/callback' => 'users#create'
  delete 'logout' => 'users#destroy'
  get '/users/:user_id/squads/new' => 'squads#new'
  get '/users/:user_id/squads/create' => 'squads#create'
  resources :users do
    resources :squads
  end


  scope '/api' do
    scope '/v1' do
      scope 'user/:id' do
        get '/squadrun' => 'order#index'
        post '/squadrun/:id/add_car' => 'order#add_squad_car'
        get '/squadrun/all' => 'order#all_squads'
      end
    end
  end
end
