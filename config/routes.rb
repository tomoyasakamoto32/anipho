Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: "posts#index"
  post '/posts/guest_sign_in', to: 'posts#new_guest'
  resources :posts do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only: [:show, :index]
  resources :relationships, only: [:create, :destroy, :index]
  get 'relationships/:id' => 'relationships#followings', as:'followings'
  get 'relationship/:id' => 'relationships#followers', as:'followers'
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  get 'likes' => 'likes#index', as: 'likes'
  get '/posts/category/:id' => "posts#category", as: 'post_category'
end
