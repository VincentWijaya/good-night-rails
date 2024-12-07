Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/ping", to: "ping#ping"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
      end

      resources :sleep_trackings, only: [:index] do
      end

      post 'follow/:following_user_id', to: 'followings#follow', as: 'follow'
      post 'unfollow/:following_user_id', to: 'followings#unfollow', as: 'unfollow'
    end
  end
end
