module Meetings
  module Events
    # Event triggered when a meeting group is proposed
    MEETING_GROUP_PROPOSED = 'meeting_group_proposed_domain_event.meetings'
    # Event triggered when a user registers in the app
    NEW_USER_REGISTERED = 'new_user_registered_domain_event.user_access'
    # Event triggered when a user confirms their email
    USER_REGISTRATION_CONFIRMED = 'user_registration_confirmed_domain_event.user_access'
    # Event triggered when an admin accepts a given meeting group proposal
    MEETING_GROUP_PROPOSAL_ACCEPTED = 'meeting_group_proposal_accepted_domain_event.administration'
    # Event triggered when a member is created sucessfully
    CREATED_MEMBER_SUCCESSFULLY = 'created_member_successfully.meetings'
  end
end
