Rails.application.routes.draw do

  
  
  get "/dashboard/get_suggestions" => "dashboard#get_suggestions"
  get "/procedure/price/:id" => "procedure#price"
  get "/procedure/get_city_suggestions" => "procedure#get_city_suggestions"
  resources :dashboard
  resources :procedure
  resources :provider
  root 'dashboard#index'
  devise_for :users

end
