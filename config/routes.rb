Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/help", to: "static_pages#help", as: "help"
    get "/about", to: "static_pages#about", as: "about"
    get "/contact", to: "static_pages#contact",as: "contact"
    get "/signup", to: "users#new", as: "signup"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "password_resets/new"
    get "password_resets/edit"
  end

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i(new create edit update)
  resources :microposts, only: %i(create destroy)
  resources :relationships, only: %i(create destroy)
end
