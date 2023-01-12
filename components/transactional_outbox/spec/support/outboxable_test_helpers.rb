module OutboxableTestHelpers
  extend RSpec::Matchers::DSL

  matcher :create_transactional_outbox_record do
    match(notify_expectation_failures: true) do |actual|
      expect { actual.call }.to change(TransactionalOutbox::Outbox, :count).by(1)

      if @attributes
        outbox = TransactionalOutbox::Outbox.last
        expect(outbox.attributes).to include(@attributes)
      end

      true
    end

    supports_block_expectations
    diffable

    chain :with_attributes do |attributes|
      @attributes = attributes
    end
  end
end
