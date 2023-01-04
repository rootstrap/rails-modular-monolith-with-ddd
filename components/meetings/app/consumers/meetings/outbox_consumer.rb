# frozen_string_literal: true

module Meetings
  class OutboxConsumer
    EVENTS_MAPPING = {
      Meetings::Events::USER_REGISTRATION_CONFIRMED => Meetings::CreateMemberService,
      Meetings::Events::MEETING_GROUP_PROPOSAL_ACCEPTED => Meetings::AcceptMeetingGroupProposalService
    }

    def initialize(payload)
      @payload = payload
    end

    def consume
      if Meetings::ConsumedMessage.already_processed?(identifier, aggregate)
        Karafka.logger.info "Already processed event: #{pretty_print_event}"
        return
      elsif EVENTS_MAPPING.keys.include?(event)
        Karafka.logger.info "New [Meetings::Outbox] event: #{pretty_print_event}"
        consumed_message = Meetings::ConsumedMessage.create!(event_id: identifier, aggregate: aggregate, status: :processing)
        begin
          EVENTS_MAPPING[event].new(data).call
          consumed_message.update!(status: :succeeded)
        rescue
          consumed_message.update!(status: :failed)
        end
      end
    end

    private

    attr_reader :payload

    def pretty_print_event
      "<identifier: #{identifier}, event: #{event} , aggregate: #{aggregate}>"
    end

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
