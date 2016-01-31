Rails.application.routes.draw do

  root "home#index"

  get 'arena/:id-:name' => 'home#show', as: :showarena
  get 'arena' => 'home#list'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'dashboard' => 'dashboard/home#index'

  namespace :dashboard do
    resources :futsal_places do
      resources :fields, :prices
    end
  end

end
