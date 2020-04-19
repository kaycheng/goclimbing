Rails.application.routes.draw do
  root "welcome#index"
  
  devise_for :users, controllers: { 
    registrations: 'users/registrations' 
  }

  resources :events

  # /@username
  get '@:username', to: 'welcome#user', as: 'user_page'

end
