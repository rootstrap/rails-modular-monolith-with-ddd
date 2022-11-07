module Meetings
  module Events
    # Event triggered when a meeting group is proposed
    MEETING_GROUP_PROPOSED = 'meeting_group_proposed_domain_event.meetings'
    # Event triggered when a user registers in the app
    NEW_USER_REGISTERED = 'new_user_registered_domain_event.user_access'
    # Event triggered when an admin accepts a given meeting group proposal
    MEETING_GROUP_PROPOSAL_ACCEPTED = 'meeting_group_proposal_accepted_domain_event.administration'
  end
end
