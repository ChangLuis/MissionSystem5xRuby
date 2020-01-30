Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'login#new', as: "login"
  post '/', to: 'login#create'
  delete 'logout', to: 'login#destroy'

  namespace :user do
    resources :missions
    get 'missions/sort/:order_change', to: 'missions#index', as: 'order_change'
  end

  namespace :admin do
    root 'users#index'
    resources :users, except: :index
  end
end
