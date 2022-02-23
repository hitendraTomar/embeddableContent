Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  resource :home, only: %w[index] do
    get :publisher_dashboard
  end

  resources :contents
end
