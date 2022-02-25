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
  resources :content_publishers do
    get :my_publications, on: :collection
  end
  get "/add_publisher/:content_id", to: "content_publishers#add_publisher", as: :add_publisher

  match "*path" => "contents#show", via: :get
end
