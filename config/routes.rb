Rails.application.routes.draw do
  devise_for :users, class_name: 'UserAccess::User', controllers: {
    registrations: 'user_access/users/registrations'
  }
end
