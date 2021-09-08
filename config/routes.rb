Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  scope module: :user do
    root 'homes#top'
    resources :exchanges, only: [:index, :show]
    resources :genres, only: [:new, :edit, :update]
    resources :inquiries, only: [:index, :new, :create]
    post 'inquiries/confirm'
    post 'inquiries/complete'
    resources :items, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
      resource :likes, only: [:create, :destroy]
    end
    resources :messages, only: [:create]
    resources :notifications, only: [:index]
    resources :reports, only: [:create, :update]
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
    resources :users, only: [:show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
