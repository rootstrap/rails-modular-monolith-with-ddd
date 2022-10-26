module UserAccess
  class OutboxService < ::OutboxService
    private

    def outbox_class
      UserAccess::Outbox
    end
  end
end
