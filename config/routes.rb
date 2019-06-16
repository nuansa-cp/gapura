Rails.application.routes.draw do
  resources :events
  root 'welcome#index'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  get '*path'       , to: 'welcome#index'
end
