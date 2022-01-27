Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, class_name: 'UserAccess::User', controllers: {
    registrations: 'user_access/users/registrations'
  }
end
