RSpec.shared_context 'Karafka consumer helpers' do
  let(:consumers) do
    [
      Support::KarafkaConsumerMock.build(
        Meetings::BatchBaseConsumer.new,
        "#{ENV["KAFKA_CONNECT_DB_SERVER_NAME"]}.public.user_access_outboxes",
        _karafka_consumer_client
      )
    ]
  end
end
