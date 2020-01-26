Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :user do
    resources :missions
    get 'missions/sort/:order_change', to: 'missions#index', as: 'order_change'
  end

  root to: 'user/missions#index'
end
