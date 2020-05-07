Rails.application.routes.draw do
  root "welcome#index"
  
  devise_for :users, controllers: { 
    registrations: 'users/registrations' 
  }

  resources :events

  resources :user, only: [] do
    member do
      post :follow
    end
  end

  # /@username
  get '@:username', to: 'welcome#user', as: 'user_page'

end
