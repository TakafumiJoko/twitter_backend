Rails.application.routes.draw do
  post "/login", to: "users#login"
  resources :users do
    resources :tweets
  end
  get "/tweets/:key", to: "tweets#search"

  get "/tags", to: "application#tags"

  get "/:key", to: "application#search"

  get "/categories", to: "categories#index"
  get "/categories/:category_id/trends", to: "trends#index"

  match '*path' => 'options_request#response_preflight_request', via: :options
end