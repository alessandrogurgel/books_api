Rails.application.routes.draw do
  namespace :api do

    get 'external-books', to: 'external_books#index'
  end
end
