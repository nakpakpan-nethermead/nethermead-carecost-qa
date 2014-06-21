Rails.application.routes.draw do

  devise_for :users
  
  get "/dashboard/get_suggestions" => "dashboard#get_suggestions"
  get "/procedure/price/:id" => "procedure#price"
  get "/procedure/get_city_suggestions" => "procedure#get_city_suggestions"
  resources :dashboard
  resources :procedure
end
