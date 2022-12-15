# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAccess::UserRegistrationService do
  describe '#call' do
    subject { described_class.new(attributes).call }

    let(:password) { 'password123' }
    let(:password_confirmation) { password }
    let(:attributes) do
      {
        login: Faker::Lorem.word,
        email: Faker::Internet.email,
        password: password,
        password_confirmation: password_confirmation,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      }
    end

    it 'creates a new user registration' do
      expect { subject }.to change(UserAccess::UserRegistration, :count).by(1)

      user_registration = UserAccess::UserRegistration.last
      expect(user_registration.status_code).to eq('waiting_for_confirmation')
    end

    it 'encrypts the password' do
      subject

      user_registration = UserAccess::UserRegistration.last
      expect(user_registration.encrypted_password).to_not eq(password)
    end

    it 'creates an outbox record' do
      expect { subject }.to change(TransactionalOutbox::Outbox, :count).by(1)
      user_registration = UserAccess::UserRegistration.last
      outbox = TransactionalOutbox::Outbox.last
      expect(outbox.event).to eq(UserAccess::Events::NEW_USER_REGISTERED)
      expect(outbox.aggregate).to eq('UserAccess::UserRegistration')
      expect(outbox.aggregate_identifier).to eq(user_registration.identifier)
    end

    context 'when the password and password confirmation do not match' do
      let(:password_confirmation) { 'wrong password' }

      it 'does not create a new user registration' do
        expect { subject }.to_not change(UserAccess::UserRegistration, :count)
      end

      it 'does not create an outbox record' do
        expect { subject }.to_not change(TransactionalOutbox::Outbox, :count)
      end
    end
  end
end
