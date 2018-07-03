Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get  "/help", to: "static_pages#help", as: "help"
    get  "/about", to: "static_pages#about", as: "about"
    get  "/contact", to: "static_pages#contact",as: "contact"
    get  "/signup", to: "users#new", as: "signup"
    post "/signup", to: "users#create"
  end
  resources :users
end
