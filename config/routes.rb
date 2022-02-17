Rails.application.routes.draw do
  root to: 'rails/welcome#index'

  devise_for :users, only: :sessions, class_name: 'UserAccess::User'
  devise_for :user_registrations, only: [:registrations, :confirmations], class_name: 'UserAccess::UserRegistration', controllers: {
    registrations: 'user_access/users/registrations'
  }

end
