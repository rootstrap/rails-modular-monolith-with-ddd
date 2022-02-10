Rails.application.routes.draw do
  root to: 'rails/welcome#index'

  devise_for :users, class_name: 'UserAccess::User', controllers: {
    registrations: 'user_access/users/registrations'
  }

  devise_for :user_registrations, class_name: 'UserAccess::UserRegistration', controllers: {
    confirmations: 'user_access/users/confirmations'
  }
end
