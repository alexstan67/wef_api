Rails.application.routes.draw do
  #get 'subscribers/index'
  
  namespace :api do
    namespace :v1 do
      get "/airports", to: "airports#index"
      get "/airports/:id", to: "airports#show"
    end
  end
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    get 'pages/console'
    root to: 'pages#home'
  end

end
