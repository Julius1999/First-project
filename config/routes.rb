Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  # get 'users/new'

  # get 'sessions/new'
  root 'static_pages#home'
  get '/home', :to =>'static_pages#home'
  get '/help',to: 'static_pages#help' 
  get '/about', to: 'static_pages#about' 
  get '/contact',  to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  get '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  # 为 AccountActivations 控制器的 edit 动作添加路由
  resources :password_resets, only: [:new, :create, :edit, :update]
end
