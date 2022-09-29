# frozen_string_literal: true

module UserAccess
  class BatchBaseConsumer < Karafka::BaseConsumer
    def consume
      messages.payloads.each do |payload|
        UserAccess::OutboxConsumer.new(payload).consume
      end
    end
  end
end