module OutboxableTestHelpers
  extend RSpec::Matchers::DSL

  matcher :create_transactional_outbox_record do
    match(notify_expectation_failures: true) do |actual|
      count = TransactionalOutbox::Outbox.count
      expect { actual.call }.to change(TransactionalOutbox::Outbox, :count).by_at_least(1)
      count = TransactionalOutbox::Outbox.count - count

      if @attributes
        @attributes = @attributes.call if @attributes.is_a? Proc
        outboxes = TransactionalOutbox::Outbox.last(count)
        expect(outboxes.map(&:attributes)).to match(array_including(hash_including(@attributes)))
      end

      true
    end

    match_when_negated(notify_expectation_failures: true) do |actual|
      expect { actual.call }.to_not change(TransactionalOutbox::Outbox, :count)
    end

    supports_block_expectations
    diffable

    chain :with_attributes do |attributes|
      @attributes = attributes
    end
  end
end
