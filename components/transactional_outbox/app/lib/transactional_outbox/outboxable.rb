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
        event: "#{action.upcase}_#{self.class.name}",
        identifier: SecureRandom.uuid,
        payload: payload(action)
      )
    end

    def payload(action)
      payload = { before: nil, after: nil }
      case action
      when :create
        payload[:after] = as_json
      when :update
        # previous_changes => { 'name' => ['bob', 'robert']  }
        changes = previous_changes.transform_values(&:first)
        payload[:before] = as_json.merge(changes)
        payload[:after] = as_json
      when :destroy
        payload[:before] = as_json
      else
        raise ActiveRecord::RecordNotSaved.new("Failed to create Outbox payload for #{self.class.name}: #{identifier}", self)
      end
      payload
    end
  end
end
