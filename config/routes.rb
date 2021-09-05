Rails.application.routes.draw do
  namespace :user do
    get 'homes/top'
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
