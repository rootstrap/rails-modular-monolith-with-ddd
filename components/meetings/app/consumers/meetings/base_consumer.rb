# frozen_string_literal: true

module Meetings
  class BaseConsumer
    def initialize(payload)
      @payload = payload
    end

    def consume
      if Meetings::ConsumedMessage.already_processed?(id, aggregate)
        Karafka.logger.info "Already processed event: <id: #{id}, aggregate: #{aggregate}>"
        return
      else
        yield
        Meetings::ConsumedMessage.create!(event_id: id, aggregate: aggregate)
      end
    end

    private

    attr_reader :payload

    def id
      payload.dig('after', 'id')
    end

    def event
      payload.dig('after', 'event')
    end

    def aggregate
      payload.dig('after', 'aggregate')
    end

    def data
      JSON.parse(payload.dig('after', 'payload'))
    end
  end
end
