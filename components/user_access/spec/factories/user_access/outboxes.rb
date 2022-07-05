# frozen_string_literal: true

FactoryBot.define do
  factory :user_access_outbox, class: 'UserAccess::Outbox' do
    event { 'new_user_registered_domain_event.user_access' }
    payload do
      {
        before: nil,
        after: {
          id: 1,
          login: 'angle_parisian',
          email: 'irwin@blanda-thiel.biz',
          encrypted_password: '$2a$12$FUctOJz69VZsYwD1xYwHBurKvqb4CC8xVDRuxt7T6GqFAlyqgysHK',
          first_name: 'Moises',
          last_name: 'Kemmer',
          name: 'Moises Kemmer',
          status_code: 1,
          registered_at: 1656104074437113,
          confirmed_at: nil,
          created_at: 1656622474653699,
          updated_at: 1656622474653699,
          confirmation_token: 'a423a2da-54c1-4a4e-ab8b-f4588874be9f',
          confirmation_sent_at: 1656536069675604,
          unconfirmed_email: nil,
          identifier: '7d8f60e3-5e7f-4c11-b18b-5cc01ceea3da'
        },
        source: {
          version: '1.9.4.Final',
          connector: 'postgresql',
          name: 'dbserver1',
          ts_ms: 1656622474660,
          snapshot: false,
          db: 'rails_modular_monolith_with_ddd_development',
          sequence: '[nil,\23382416\]',
          schema: 'public',
          table: 'user_access_user_registrations',
          txId: 509,
          lsn: 23382416,
          xmin: nil
        },
        op: 'c',
        ts_ms: 1656622474973,
        transaction: nil
      }
    end
    aggregate { UserAccess::UserRegistration.name }
    identifier { SecureRandom.uuid }
  end
end
