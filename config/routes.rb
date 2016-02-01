Rails.application.routes.draw do

  root "home#index"

  get 'arena/:id-:name' => 'home#show', as: :showarena
  get 'arena' => 'home#list'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'dashboard' => 'dashboard/home#index'
  get 'dashboard_admin' => 'dashboard_admin/home#index'

  namespace :dashboard do
    resources :futsal_places do
      resources :prices
    end
  end

  namespace :dashboard_admin do
    resources :futsal_places
  end

  namespace :dashboard_admin do
    resources :prices
  end

end
