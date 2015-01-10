Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users
  resources :stories do
    resource :reply, except: :show
  end

  root to: "home#index"
end
