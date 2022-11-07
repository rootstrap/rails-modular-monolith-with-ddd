# frozen_string_literal: true

module Meetings
  class OutboxConsumer
    EVENTS_MAPPING = {
      Meetings::Events::NEW_USER_REGISTERED => Meetings::CreateMemberService,
      Meetings::Events::MEETING_GROUP_PROPOSAL_ACCEPTED => Meetings::AcceptMeetingGroupProposalService
    }

    def initialize(payload)
      @payload = payload
    end

    def consume
      if Meetings::ConsumedMessage.already_processed?(identifier, aggregate)
        Karafka.logger.info "Already processed event: <identifier: #{identifier}, aggregate: #{aggregate}>"
        return
      else
        Karafka.logger.info "New [Meetings::Outbox] event: <identifier: #{identifier}, aggregate: #{aggregate}>"
        EVENTS_MAPPING[event].new(data).call
        Meetings::ConsumedMessage.create!(event_id: identifier, aggregate: aggregate)
      end
    end

    private

    attr_reader :payload

    def id
      payload.dig('payload', 'after', 'id')
    end

    def identifier
      payload.dig('payload', 'after', 'identifier')
    end

    def event
      payload.dig('payload', 'after', 'event')
    end

    def aggregate
      payload.dig('payload', 'after', 'aggregate')
    end

    def data
      JSON.parse(payload.dig('payload', 'after', 'payload'))
    end
  end
end
