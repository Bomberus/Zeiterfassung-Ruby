Rails.application.routes.draw do
  resources :users
  get "/pages/:page" => "pages#show"
  get :login, to: 'session#new'
  post :login, to: 'session#create'
  delete :login, to: 'session#destroy'

  post '/add_arrival', to: "users#add_arrival"
  post '/add_departure', to: "users#add_departure"

  root "pages#show", page: "welcome"
end
