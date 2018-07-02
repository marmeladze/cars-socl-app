Rails.application.routes.draw do
  devise_for :users, :controllers => { sessions: 'users/sessions', :registrations => "users/registrations",
                                      :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users do
    collection do
      get :news_feed
      get :profile
      get :search
    end
    member do
      post :upload_pic
      get :profile
    end
    resources :dream_garages, only: [:create, :destroy]
  end
  
  resources :companies do
    member do
      post :upload_pic 
    end
  end

  resources :groups do
    member do
      post :upload_pic 
    end
  end

  resources :events do
    member do
      post :attend
      post :drop
      post :join_request
      put :accept_request
      get :accept_invitation
      post :send_invitations
      post :upload_pic
    end
  end

  resources :motors do
    collection do
      get :look_up, constraints: { format: 'json' }
    end
    member do
      post :upload_pic
    end
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :posts, only: [:create, :show] do
    member do
      post :like
      post :dislike
      post :create_comment
      post :add_reply
      post :like_comment
      post :dislike_comment
    end

    resource :comments, only: %i[destroy]
  end


  resources :settings, only: [] do
    collection do
      match '/account' => 'settings#account', via: [:get, :post]
      match '/privacy' => 'settings#privacy', via: [:get, :post]
      match '/notifications' => 'settings#notifications', via: [:get, :post]
      match '/security' => 'settings#security', via: [:get, :post]
    end
  end

  resources :utils, only: [] do
    collection do
      get :states_list
      get :cities_list
      get :location_search
    end
  end

  resources :follow, only: [] do
    collection do
      post :user
      post :unfollow_user
      post :motor
      post :unfollow_motor
      post :company
      post :unfollow_company
    end
  end

  resources :notifications, only: [:index] do

  end

  resource :search, controller: 'search', only: [] do
    collection do
      get :people
      get :companies
      get :motors
      get :groups
      get :events
    end
  end

  get '/publish/:type', to: 'posts#new', as: :publish_blog
  get '/news_feed', to: 'users#news_feed', as: :news_feed
  get '/profile', to: 'users#profile', as: :user_profile
end
