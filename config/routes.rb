Rails.application.routes.draw do
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/users', to: "users#search"

  # post 'users', to: 'sessions#create'
  post 'users', to: 'users#create'
  get 'users/:username', to: 'users#show'
  get 'users/:username/tweets', to: 'tweets#index'
  post 'users/:username/tweets', to: 'tweets#create'
  # resources :users do
  #   resources :tweets
  # end

  # resources :users do
  #   resource :relationships, only: [:create, :destroy, :followings, :followers]
  #     post 'follow/:followed_id' => 'relationships#create', as: 'follow'
  #     delete 'unfollow/:followed_id' => 'relationships#destroy', as: 'unfollow'
  #     get 'followings' => 'relationships#followings', as: 'followings'
  #     get 'followers' => 'relationships#followers', as: 'followers'
  # end

  post "/users/:username/tweets/:id/replies", to: "tweets#reply"
  get "/users/:username/tweets/:id/replies", to: "tweets#replies"

  resources :categories, only: [:index] do
    resources :hash_tags, only: [:index]
  end

  post 'images', to: 'images#create'

  get "hash_tag/tweets/:id", to: "tweets#hash_tag"

  get "main", to: "categories#main"

  get 'searches/data', to: 'searches#data'
  get 'searches/tweets', to: 'searches#tweets'

  get 'tweets/:q', to: "tweets#search"

  get "/tags", to: "application#tags"

  get "/:key", to: "application#search"

  match '*path' => 'options_request#response_preflight_request', via: :options
end