Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  
  scope module: :public do
    root to: 'homes#top'
    get 'homes/about' , as: 'about'
  end
  
  # namespace :public do
  #   get 'homes/top'
  #   get 'homes/about'
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
