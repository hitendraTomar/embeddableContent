Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  resource :home, only: %w[index] do
    get :publisher_dashboard
  end

  resources :contents do
     get 'page/:page', action: :index, on: :collection
  end
  resources :content_stylesheets
  resources :content_publishers
  get "/add_publisher/:content_id", to: "content_publishers#add_publisher", as: :add_publisher
  get "/:id/add_stylesheet", to: "contents#add_stylesheet", as: :add_stylesheet
  get "/:id/remove_stylesheet/:stylesheet_id", to: "contents#remove_stylesheet", as: :remove_stylesheet
end
