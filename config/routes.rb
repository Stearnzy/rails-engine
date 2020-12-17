Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'most_items_sold#index'
      end
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :merchants do
        get '/items', to: 'merchants/items#index'
      end
      resources :items do
        get '/merchants', to: 'items/merchants#show'
      end
    end
  end
end
