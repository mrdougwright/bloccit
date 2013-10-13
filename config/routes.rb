Bloccit::Application.routes.draw do
  get "comments/new"
  devise_for :users
  resources :topics do
    resources :posts, except: [:index]
    reources :comments, only: [:create]
  end

  match "about" => 'welcome#about', via: :get
  
  root to: "welcome#index"
end
