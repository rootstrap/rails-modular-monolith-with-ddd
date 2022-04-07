module Meetings
  class CreateMeetingGroupProposalService
    attr_reader :description, :location_city :location_country_code, :name, :identifier

    def initialize(attributes, proposal_user_identifier)
      @description = attributes[:description]
      @location_city = attributes[:location_city]
      @location_country_code = attributes[:location_country_code]
      @name = attributes[:name]
      @identifier = proposal_user_identifier
    end

    def call
      valid = meeting_group_proposal.save

      if valid
        ActiveSupport::Notifications.instrument(
          'meeting_group_proposed_domain_event.meetings',
          meeting_group_proposed_domain_event_payload
        )
      end

      valid
    end

    private

    def meeting_group_proposal
      @meeting_group_proposal ||= MeetingGroupProposal.new(
        description: description,
        location_city: location_city,
        location_country_code: location_country_code,
        name: name,
        proposal_date: Time.current,
        status_code: :in_verification,
        proposal_user_id: member.id
      )
    end

    def member
      @member ||= Member.find_by(identifier: identifier)
    end

    def meeting_group_proposed_domain_event_payload
      {
        id: meeting_group_proposal.id,
        description: meeting_group_proposal.description,
        location_city: meeting_group_proposal.location_city,
        location_country_code: meeting_group_proposal.location_country_code,
        name: meeting_group_proposal.name,
        proposal_date: meeting_group_proposal.proposal_date,
        status_code: meeting_group_proposal.status_code,
        proposal_user_id: meeting_group_proposal.proposal_user_id
      }
    end
  end
end
