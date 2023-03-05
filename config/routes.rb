Rails.application.routes.draw do
  post "/signup", to: "users#create"
  post "/login", to: "users#login"
  post "/tweet", to: "tweets#create"
  get "/users/:id", to: "users#show"
end