# frozen_string_literal: true

module UserAccess
  class OutboxConsumer
    def initialize(payload)
      @payload = payload
    end

    def consume
      if UserAccess::ConsumedMessage.already_processed?(id, aggregate)
        Karafka.logger.info "Already processed event: <id: #{id}, aggregate: #{aggregate}>"
        return
      else
        Karafka.logger.info "New [UserAccess::Outbox] event: <id: #{id}, aggregate: #{aggregate}>"
        if event == 'new_user_registered_domain_event.user_access'
          UserAccess::SendUserConfirmationEmailService.new(data).call
        end

        UserAccess::ConsumedMessage.create!(event_id: id, aggregate: aggregate)
      end
    end

    private

    attr_reader :payload

    def id
      payload.dig('payload', 'after', 'id')
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
