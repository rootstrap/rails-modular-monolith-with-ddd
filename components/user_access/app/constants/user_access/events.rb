module UserAccess
  module Events
    # Event triggered when a user registers in the app
    NEW_USER_REGISTERED = 'NEW_USER_REGISTERED.USER_ACCESS'
    # Event triggered when a user confirms their email
    USER_REGISTRATION_CONFIRMED = 'USER_REGISTRATION_CONFIRMED.USER_ACCESS'
    # Event triggered when a member is created sucessfully
    MEMBER_CREATED_SUCCEEDED = 'MEMBER_CREATED_SUCCEEDED.MEETINGS'
    # Event triggered when a member fails to be created
    MEMBER_CREATED_FAILED = 'MEMBER_CREATED_FAILED.MEETINGS'
    USER_ACTIVATION_SUCCEEDED = 'USER_ACTIVATION_SUCCEEDED.USER_ACCESS'
    USER_ACTIVATION_FAILED = 'USER_ACTIVATION_FAILED.USER_ACCESS'
  end
end
