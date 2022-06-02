Rails.application.routes.draw do
  draw(:user_access)

  authenticated do
    root to: 'rails/welcome#index'
  end

  devise_scope :user do
    unauthenticated do
      root to: 'user_access/users/sessions#new', as: :unauthenticated_root
    end
  end
end
