# typed: false
module Meetings
  class AcceptMeetingGroupProposalService
    attr_reader :meeting_group_proposal

    def initialize(event_payload)
      @meeting_group_proposal = MeetingGroupProposal.find(event_payload[:meeting_group_proposal_id])
    end

    def call
      return if meeting_group_proposal.accepted?

      meeting_group_proposal.accepted!

      CreateMeetingGroupService.new(
        description: meeting_group_proposal.description,
        name: meeting_group_proposal.name,
        location_city: meeting_group_proposal.location_city,
        location_country_code: meeting_group_proposal.location_country_code,
        creator_id: meeting_group_proposal.proposal_user_id,
        meeting_group_proposal_id: meeting_group_proposal.id
      ).call
    end
  end
end
