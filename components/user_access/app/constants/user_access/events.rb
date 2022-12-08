module UserAccess
  module Events
    # Event triggered when a user registers in the app
    NEW_USER_REGISTERED = 'new_user_registered_domain_event.user_access'
    # Event triggered when a user confirms their email
    USER_REGISTRATION_CONFIRMED = 'user_registration_confirmed_domain_event.user_access'
    # Event triggered when a member is created sucessfully
    CREATED_MEMBER_SUCCESSFULLY = 'created_member_successfully.meetings'
    USER_ACTIVATION_SUCCEEDED = 'user_activation_succeeded.user_access'
    USER_ACTIVATION_FAILED = 'user_activation_failed.user_access'
  end
end
