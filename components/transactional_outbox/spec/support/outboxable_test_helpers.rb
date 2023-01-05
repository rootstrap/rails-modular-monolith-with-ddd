module OutboxableTestHelpers
  extend RSpec::Matchers::DSL

  matcher :create_transactional_outbox_record do
    match do |actual|
      expect { actual.call }.to change(TransactionalOutbox::Outbox, :count).by(1)

      # Add diff
      if @attributes
        outbox = TransactionalOutbox::Outbox.last
        expect(outbox.attributes.include?(@attributes))
      end

      true
    end

    chain :with_attributes do |attributes|
      @attributes = attributes
    end

    def supports_block_expectations?
      true
    end
  end
end
