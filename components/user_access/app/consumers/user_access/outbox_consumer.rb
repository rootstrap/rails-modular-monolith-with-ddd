# frozen_string_literal: true

module UserAccess
  class OutboxConsumer
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

    def payload
      params.payload['payload']
    end
  end
end
