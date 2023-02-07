# frozen_string_literal: true

require 'waterdrop'
require 'karafka/testing/errors'
require 'karafka/testing/spec_consumer_client'
require 'karafka/testing/spec_producer_client'
require 'karafka/testing/rspec/proxy'

module Karafka
  module Testing
    # All the things related to extra functionalities needed to easier spec out
    # Karafka things using RSpec
    module RSpec
      # RSpec helpers module that needs to be included
      module Helpers
        def _karafka_add_message_to_consumer_if_needed(message)
          # Consumer needs to be defined in order to pass messages to it
          return unless defined?(consumers)
          # We're interested in adding message to consumer only when it is a Karafka consumer
          # Users may want to test other things (models producing messages for example) and in
          # their case consumer will not be a consumer
          # We target to the consumer only messages that were produced to it, since specs may also
          # produce other messages targeting other topics
          #return unless message[:topic] == consumer.topic.name

          consumers_with_topic = consumers.select { |consumer| consumer.topic.name == message[:topic] }
          topic = consumers_with_topic.first.topic

          metadata = _karafka_message_metadata_defaults(topic)

          metadata.keys.each do |key|
            next unless message.key?(key)

            metadata[key] = message.fetch(key)
          end

          # Add this message to previously produced messages
          _karafka_consumer_messages << Karafka::Messages::Message.new(
            message[:payload],
            Karafka::Messages::Metadata.new(metadata).freeze
          )

          consumers_with_topic.each do |consumer|
            next unless consumer.is_a?(Karafka::BaseConsumer)

            batch_metadata = Karafka::Messages::Builders::BatchMetadata.call(
              _karafka_consumer_messages,
              consumer.topic,
              Time.now
            )

            consumer.messages = Karafka::Messages::Messages.new(
              _karafka_consumer_messages,
              batch_metadata
            )
          end
        end

        def _karafka_produce(payload, metadata = {})
          MAPPINGS = {
            'MEETINGS' => "#{ENV["KAFKA_CONNECT_DB_SERVER_NAME"]}.public.meetings_outboxes"
          }
          # TODO: add before for destroy case
          topic = MAPPINGS[JSON.parse(payload)['payload']['after']['event'].slice('.').last]

          Karafka.producer.produce_sync(
            {
              topic: consumer.topic.name,
              payload: payload
            }.merge(metadata)
          )
        end

        def _karafka_message_metadata_defaults(topic)
          {
            deserializer: topic.deserializer,
            timestamp: Time.now,
            headers: {},
            key: nil,
            offset: _karafka_consumer_messages.size,
            partition: 0,
            received_at: Time.now,
            topic: topic.name
          }
        end
      end
    end
  end
end
