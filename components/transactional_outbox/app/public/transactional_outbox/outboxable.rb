# frozen_string_literal: true

module TransactionalOutbox
  module Outboxable
    extend ActiveSupport::Concern

    included do
      after_create { create_outbox!(:create) }
      after_update { create_outbox!(:update) }
      after_destroy { create_outbox!(:destroy) }
    end

    def save(**options, &block)
      if options[:outbox_event].present?
        @outbox_event = options[:outbox_event].underscore.upcase
      end

      super(**options, &block)
    end

    def save!(**options, &block)
      if options[:outbox_event].present?
        @outbox_event = options[:outbox_event].underscore.upcase
      end

      super(**options, &block)
    end

    private

    def create_outbox!(action)
      outbox = TransactionalOutbox::Outbox.new(
        aggregate: self.class.name,
        aggregate_identifier: identifier,
        event: @outbox_event || "#{action.upcase}_#{self.class.name.underscore.upcase}",
        identifier: SecureRandom.uuid,
        payload: payload(action)
      )
      @outbox_event = nil

      if outbox.invalid?
        outbox.errors.each do |error|
          self.errors.import(error, attribute: "outbox.#{error.attribute}")
        end
      end

      outbox.save!
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
