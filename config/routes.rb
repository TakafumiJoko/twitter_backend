Rails.application.routes.draw do
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

  post "/login", to: "users#login"

  post "/users/:user_id/tweets/:id/replies", to: "tweets#reply"
  get "/users/:user_id/tweets/:id/replies", to: "tweets#replies"
  get "/tweets/:key", to: "tweets#search"

  get "/tags", to: "application#tags"

  get "/:key", to: "application#search"

  get "/categories", to: "categories#index"
  get "/categories/:category_id/trends", to: "trends#index"

  match '*path' => 'options_request#response_preflight_request', via: :options
end