module Support
  class KafkaConnectMock
    def self.wrap_message(message)
      message = message.as_json.tap { |h| h['payload'] = h['payload'].to_json }
      event_payload = { payload: { after: message } }
      event_payload.to_json
    end
  end
end
