Rails.application.routes.draw do

  
  
  get "/dashboard/get_suggestions" => "dashboard#get_suggestions"
  get "/dashboard/email_share" => "dashboard#email_share"
  get "/procedure/price/:id" => "procedure#price"
  get "/procedure/get_city_suggestions" => "procedure#get_city_suggestions"
  get "/provider/makefav" => "provider#makefav"
  post "/procedure/fav_list" => "procedure#fav_list"
  resources :dashboard
  resources :procedure
  resources :provider
  root 'dashboard#index'
  devise_for :users

end
