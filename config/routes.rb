Rails.application.routes.draw do
  resources :books
  namespace :api do
    get 'external-books', to: 'external_books#index'

    namespace :v1 do
      resources :books, only: [:create, :index, :update, :show, :destroy ]
    end
  end
end
