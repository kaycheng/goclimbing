Rails.application.routes.draw do
  root "welcome#index"
  
  devise_for :users, controllers: { 
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
  end

 
  resources :users, only: [] do
    member do
      # users/:id/follow
      post :follow
    end
  end

  # /@username
  get '@:username', to: 'welcome#user', as: 'user_page'
  get '@:username/followers', to: 'welcome#followers', as: 'followers_user'
  get '@:username/followings', to: 'welcome#followings', as: 'followings_user'

end
