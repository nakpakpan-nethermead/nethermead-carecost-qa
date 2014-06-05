Rails.application.routes.draw do

  devise_for :users
  
  get "/dashboard/get_suggestions" => "dashboard#get_suggestions"
  resources :dashboard
end
