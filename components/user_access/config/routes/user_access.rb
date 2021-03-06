devise_for :users, only: :sessions, class_name: 'UserAccess::User', controllers: {
  sessions: 'user_access/users/sessions'
}
devise_for :user_registrations, only: [:registrations, :confirmations], path: :users, class_name: 'UserAccess::UserRegistration', controllers: {
  registrations: 'user_access/users/registrations',
  confirmations: 'user_access/users/confirmations'
}
