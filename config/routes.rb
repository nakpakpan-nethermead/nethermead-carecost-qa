Rails.application.routes.draw do

  devise_for :users
  
  get "/dashboard/get_suggestions" => "dashboard#get_suggestions"
  get "/procedure/price/:id" => "procedure#price"
  resources :dashboard
  resources :procedure
end
