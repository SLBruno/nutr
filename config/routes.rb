Rails.application.routes.draw do
  	resources :lists

  	devise_for :users 
 	resources :recipes do
 		member do 
 			get '/listrecipe', to: 'recipes#listit'
 		end 
 	end 

 	root "recipes#index"

  	

end
