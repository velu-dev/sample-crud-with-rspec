Rails.application.routes.draw do
  
  get 'sessions/index'
  get 'sessions/login'
  get 'sessions/logout'
  post 'sessions/login_auth'
  post "sessions/otp"
#get '/authenticate/:id', to: 'sessions#authenticate'
get 'sessions/authenticate'
resources :users
root "sessions#login"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
