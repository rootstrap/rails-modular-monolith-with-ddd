module Meetings
  class OutboxService < ::OutboxService
    private

    def outbox_class
      Meetings::Outbox
    end
  end
end
