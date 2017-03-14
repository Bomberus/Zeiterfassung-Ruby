Rails.application.routes.draw do
  resources :users
  get "/pages/:page" => "pages#show"
  get :login, to: 'session#new'
  post :login, to: 'session#create'
  delete :login, to: 'session#destroy'


  root "pages#show", page: "welcome"
end
