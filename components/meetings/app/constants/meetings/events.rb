module Meetings
  module Events
    # Event triggered when a meeting group is proposed
    MEETING_GROUP_PROPOSED = 'MEETING_GROUP_PROPOSED.MEETINGS'
    # Event triggered when a user registers in the app
    NEW_USER_REGISTERED = 'NEW_USER_REGISTERED.USER_ACCESS'
    # Event triggered when a user confirms their email
    USER_REGISTRATION_CONFIRMED = 'USER_REGISTRATION_CONFIRMED.USER_ACCESS'
    # Event triggered when an admin accepts a given meeting group proposal
    MEETING_GROUP_PROPOSAL_ACCEPTED = 'MEETING_GROUP_PROPOSAL_ACCEPTED.ADMINISTRATION'
    # Event triggered when a member is created sucessfully
    MEMBER_CREATED_SUCCEEDED = 'MEMBER_CREATED_SUCCEEDED.MEETINGS'
    # Event triggered when a member fails to be created
    MEMBER_CREATED_FAILED = 'MEMBER_CREATED_FAILED.MEETINGS'
  end
end
