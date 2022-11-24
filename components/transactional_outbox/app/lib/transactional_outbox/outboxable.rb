# frozen_string_literal: true

module TransactionalOutbox
  module Outboxable
    extend ActiveSupport::Concern

    included do
      after_create { create_outbox!(:create) }
      after_update { create_outbox!(:update) }
      after_destroy { create_outbox!(:destroy) }
    end

    private

    def create_outbox!(action)
      TransactionalOutbox::Outbox.create!(
        aggregate: self.class.name,
        aggregate_identifier: identifier,
        event: "#{action} #{self.class.name}",
        identifier: SecureRandom.uuid,
        payload: as_json
      )
    end
  end
end
