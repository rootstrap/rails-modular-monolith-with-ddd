# frozen_string_literal: true

module Meetings
  class OutboxConsumer
    def initialize(payload)
      @payload = payload
    end

    def consume
      if Meetings::ConsumedMessage.already_processed?(identifier, aggregate)
        Karafka.logger.info "Already processed event: <identifier: #{identifier}, aggregate: #{aggregate}>"
        return
      else
        Karafka.logger.info "New [Meetings::Outbox] event: <identifier: #{identifier}, aggregate: #{aggregate}>"
        if event == 'new_user_registered_domain_event.user_access'
          Meetings::CreateMemberService.new(data).call
        end

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
