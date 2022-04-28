module Meetings
  class AcceptMeetingGroupProposalService
    attr_reader :meeting_group_proposal

    def initialize(event_payload)
      @meeting_group_proposal = MeetingGroupProposal.find(event_payload[:meeting_group_proposal_id])
    end

    def call
      return if meeting_group_proposal.accepted?

      meeting_group_proposal.accepted!
      # call create group service
    end
  end
end