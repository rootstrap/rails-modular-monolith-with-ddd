Rails.application.routes.draw do
  root to: 'rails/welcome#index'

  devise_for :users, only: [:registrations, :confirmations], class_name: 'UserAccess::UserRegistration', controllers: {
    registrations: 'user_access/users/registrations'
  }

  devise_for :users, only: :sessions, class_name: 'UserAccess::User'
end
