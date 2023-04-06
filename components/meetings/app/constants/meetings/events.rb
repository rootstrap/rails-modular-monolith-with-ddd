module Meetings
  module Events
    # Event triggered when a meeting group is proposed
    MEETING_GROUP_PROPOSED = 'MEETING_GROUP_PROPOSED_DOMAIN_EVENT.MEETINGS'
    # Event triggered when a user registers in the app
    NEW_USER_REGISTERED = 'NEW_USER_REGISTERED_DOMAIN_EVENT.USER_ACCESS'
    # Event triggered when an admin accepts a given meeting group proposal
    MEETING_GROUP_PROPOSAL_ACCEPTED = 'MEETING_GROUP_PROPOSAL_ACCEPTED_DOMAIN_EVENT.ADMINISTRATION'
  end
end
