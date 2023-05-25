# frozen_string_literal: true

module Meetings
  class BatchBaseConsumer < Karafka::BaseConsumer
    def consume
      messages&.payloads&.each do |payload|
        Meetings::OutboxConsumer.new(payload).consume
      end
    end
  end
end
