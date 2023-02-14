# Follow karafka.rb config to match the consumers defined here
RSpec.shared_context 'Karafka consumer helpers' do
  let(:consumers) do
    Karafka::App.routes.map do |cg|
      next if cg.name == 'app'
      cg.topics.map do |t|
        Support::KarafkaConsumerMock.build(
          t.consumer.new,
          t.name,
          _karafka_consumer_client
        )
      end
    end.flatten.compact
  end
end
