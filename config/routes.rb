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

  # users/:id/follow
  resources :users, only: [] do
    member do
      post :follow

      get :followers
      get :followings
    end
  end

  # /@username
  get '@:username', to: 'welcome#user', as: 'user_page'

end
