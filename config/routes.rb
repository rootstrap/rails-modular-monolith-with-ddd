Rails.application.routes.draw do
  devise_for :users, only: :sessions, class_name: 'UserAccess::User', controllers: {
    sessions: 'user_access/users/sessions'
  }
  devise_for :user_registrations, only: [:registrations, :confirmations], path: :users, class_name: 'UserAccess::UserRegistration', controllers: {
    registrations: 'user_access/users/registrations',
    confirmations: 'user_access/users/confirmations'
  }

  authenticated do
    root to: 'rails/welcome#index'
  end

  devise_scope :user do
    unauthenticated do
      root to: 'user_access/users/sessions#new', as: :unauthenticated_root
    end
  end

  namespace :meetings do
    resources :meeting_group_proposals
  end
end
