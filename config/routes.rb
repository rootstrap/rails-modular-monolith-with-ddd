Rails.application.routes.draw do
  devise_for :users, class_name: 'UserAccess::User'
end
