# frozen_string_literal: true

FactoryBot.define do
  factory :transactional_outbox_outbox, class: 'TransactionalOutbox::Outbox' do
    aggregate { 'Aggregate' }
    aggregate_identifier { SecureRandom.uuid }
    event { 'Event' }
    identifier { SecureRandom.uuid }
    payload do
      {
        before: nil,
        after: {
          id: 1,
          identifier: '7d8f60e3-5e7f-4c11-b18b-5cc01ceea3da'
        }
      }
    end
  end
end
