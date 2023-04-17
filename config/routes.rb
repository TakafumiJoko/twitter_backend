Rails.application.routes.draw do
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/users', to: "users#search"

  resources :users do
    resources :tweets
  end

  resources :users do
    resource :relationships, only: [:create, :destroy, :followings, :followers]
      post 'follow/:followed_id' => 'relationships#create', as: 'follow'
      delete 'unfollow/:followed_id' => 'relationships#destroy', as: 'unfollow'
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
  end


  post "/users/:user_id/tweets/:id/replies", to: "tweets#reply"
  get "/users/:user_id/tweets/:id/replies", to: "tweets#replies"

  resources :tweets do
    resources :hash_tags, only: [:create]
  end

  resources :trends

  get 'searches/data', to: 'searches#data'
  get 'searches/tweets', to: 'searches#tweets'

  get 'tweets/:q', to: "tweets#search"

  get "/tags", to: "application#tags"

  get "/:key", to: "application#search"

  get "/categories", to: "categories#index"
  get "/categories/:category_id/trends", to: "trends#index"

  match '*path' => 'options_request#response_preflight_request', via: :options
end