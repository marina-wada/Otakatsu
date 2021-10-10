Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  devise_scope :user do
    get '/users', to: 'users/registrations#new'
  end

  scope module: :user do
    root 'homes#top'
    resources :exchanges, only: [:index, :show]
    resources :genres, only: [:new, :create, :edit, :update]
    resources :inquiries, only: [:index, :new, :create]
    post 'inquiries/confirm'
    post 'inquiries/complete'
    resources :items, only: [:index, :show, :create, :destroy, :edit, :update] do
      resource :likes, only: [:create, :destroy]
      resource :reports, only: [:create]
      member do
        get 'check'
        patch 'withdrawl'
      end
      get :search, on: :collection
    end
    get 'genres/:genre_id/items/new', to:'items#new', as:'new_item'
    resources :messages, only: [:create]
    resources :notifications, only: [:index]
    resources :rooms, only: [:create, :show]
    resources :users, only: [:show, :edit, :update] do
      member do
        get 'check'
        patch 'withdrawl'
      end
      collection do
        get 'unsubscribe'
        patch 'withdrawl'
      end
    end
  end

  namespace :admin do
    root 'homes#top'
    resources :exchanges, only: [:index]
    resources :inquiries, only: [:index, :new, :create]
    resources :items, only: [:index]
    resources :reports, only: [:index]
    resources :users, only: [:index,:show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
