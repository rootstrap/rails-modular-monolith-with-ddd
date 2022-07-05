module Meetings
  class OutboxConsumer < BaseConsumer
    def consume
      super do
        Karafka.logger.info "New [Meetings::Outbox] event: <id: #{id}, aggregate: #{aggregate}>"
        if event == 'new_user_registered_domain_event.user_access'
          Meetings::CreateMemberService.new(data).call
        end
      end
    end
  end
end
