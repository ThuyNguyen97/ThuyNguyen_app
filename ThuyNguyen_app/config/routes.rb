Rails.application.routes.draw do
  get  "/signup", to: "user#new", as: "signup"
  get  "/help", to: "static_pages#help", as: "help"
  get  "/about", to: "static_pages#about", as: "about"
  get  "/contact", to: "static_pages#contact",as: "contact"
  root "static_pages#home"
end
