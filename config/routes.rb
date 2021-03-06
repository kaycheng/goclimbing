Rails.application.routes.draw do
  root "welcome#index"
  
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations' 
  }

  resources :events do
    member do
      # events/:id/participate
      post :participated
      post :unparticipated
    end

    collection do
      get :draft
      get :public
    end

    resources :comments, only: [:create]
  end

 
  resources :users, only: [] do
    member do
      # users/:id/follow
      post :follow
    end
  end

  namespace :dashboard do 
    get 'welcome', to: 'welcome#index'
    resources :events, only: [:index, :destroy]
    resources :users, only: [:index, :destroy]
  end

  # /@username
  get '@:username', to: 'welcome#user', as: 'user_page'
  get '@:username/followers', to: 'welcome#followers', as: 'followers_user'
  get '@:username/followings', to: 'welcome#followings', as: 'followings_user'

end
