Rails.application.routes.draw do
  
  namespace :admins do
    root to: 'homes#top'
  end
  
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admins/sessions"
  }

  devise_for :users, controllers: {
    # ↓ローカルに追加されたコントローラーを参照する(コントローラー名: "コントローラーの参照先")
    registrations: "public/registrations",
    sessions: "public/sessions",
    passwords: "public/passwords",
    confirmations: "public/confirmations"
  }
  
  scope module: :public do
    root to: 'homes#top'
    get 'homes/about' , as: 'about'
    resources 'stickers', only: [:index, :show] do
      resource 'checks', only: [:create, :destroy]
    end
    resources 'shops', only: [:show]
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
