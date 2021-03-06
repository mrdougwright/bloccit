Bloccit::Application.routes.draw do
  
  get "comments/create"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
      match '/up-vote', to: 'votes#up_vote', as: :up_vote, via: [:get, :post]
      match '/down-vote', to: 'votes#down_vote', as: :down_vote, via: [:get, :post]
      resources :favorites, only: [:create, :destroy]
    end
  end

  match "about" => 'welcome#about', via: :get
  
  root to: "welcome#index"
end
