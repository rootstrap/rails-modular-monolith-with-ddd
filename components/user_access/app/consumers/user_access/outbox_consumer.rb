# frozen_string_literal: true

module UserAccess
  class OutboxConsumer
    EVENTS_MAPPING = {
      UserAccess::Events::NEW_USER_REGISTERED => UserAccess::SendUserConfirmationEmailService,
      UserAccess::Events::USER_REGISTRATION_CONFIRMED => UserAccess::CreateUserService,
      UserAccess::Events::CREATED_MEMBER_SUCCESSFULLY => UserAccess::ActivateUserService
    }

    def initialize(payload)
      @payload = payload
    end

    def consume
      if UserAccess::ConsumedMessage.already_processed?(identifier, aggregate)
        Karafka.logger.info "Already processed event: #{pretty_print_event}"
        return
      elsif EVENTS_MAPPING.keys.include?(event)
        Karafka.logger.info "New [UserAccess::Outbox] event: #{pretty_print_event}"
        EVENTS_MAPPING[event].new(data).call
        UserAccess::ConsumedMessage.create!(event_id: identifier, aggregate: aggregate)
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
