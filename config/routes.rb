Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#home"
  root "pages#home"

  post "vectors/calculate", to: "vectors#calculate", as: :vector_calculate

  post "registration", to: "registrations#create", as: :registration

  post "login",        to: "sessions#create",        as: :login
  delete "logout",      to: "sessions#delete",       as: :logout

  # роутинга для пароля пока нет, сложно
  # заглушка для фронта
  post "password/reset",    to: "password#create",      as: :password


  get "history", to: "pages#history", as: :history_page
  get "support", to: "pages#support", as: :support_page
  get "profile", to: "pages#profile", as: :profile_page

  post '/calculate', to: 'vectors#calculate', as: :calculate
end
