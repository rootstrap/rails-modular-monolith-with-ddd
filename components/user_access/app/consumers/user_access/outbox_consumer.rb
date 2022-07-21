module UserAccess
  class OutboxConsumer < BaseConsumer
    def consume
      super do
        Karafka.logger.info "New [UserAccess::Outbox] event: <id: #{id}, aggregate: #{aggregate}>"
        if event == 'new_user_registered_domain_event.user_access'
          UserAccess::SendUserConfirmationEmailService.new(data).call
        end
      end
    end
  end
end
