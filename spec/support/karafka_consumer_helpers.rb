# Follow karafka.rb config to match the consumers defined here
RSpec.shared_context 'Karafka consumer helpers' do
  let(:consumers) do
    Karafka::App.routes
      .reject { |cg| cg.name == 'app' } # We reject the default Karafka consumer
      .flat_map(&:topics)
      .flat_map do |topics|
        topics.map { |topic| build_consumer_mock(topic) }
      end
  end

  def build_consumer_mock(topic)
    Support::KarafkaConsumerMock.build(
      topic.consumer.new,
      topic.name,
      _karafka_consumer_client
    )
  end
end
