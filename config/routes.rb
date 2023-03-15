Rails.application.routes.draw do
  post "/login", to: "users#login"
  resources :users do
    resources :tweets
  end
  get "/:key", to: "application#search"
  match '*path' => 'options_request#response_preflight_request', via: :options
end