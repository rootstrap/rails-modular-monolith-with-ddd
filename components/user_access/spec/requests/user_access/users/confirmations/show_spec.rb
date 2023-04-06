# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /users/confirmations' do
  let(:user_registration) { create(:user_access_user_registration) }
  let(:request) do
    get user_registration_confirmation_path, params: params
  end

  context 'when params are valid' do
    let(:params) do
      {
        confirmation_token: user_registration.confirmation_token
      }
    end

    it 'creates a new user' do
      expect { request }.to change(UserAccess::User, :count).by(1)
    end

    it 'creates an outbox record' do
      expect { request }.to create_outbox_record(UserAccess::Outbox).with_attributes(
          'event' => UserAccess::Events::USER_REGISTRATION_CONFIRMED,
          'aggregate' => 'UserAccess::UserRegistration',
          'aggregate_identifier' => user_registration.identifier
        )
    end

    it 'redirects to home page' do
      expect(request).to redirect_to('/')
    end
  end

  context 'when params are not valid' do
    let(:params) do
      {
        confirmation_token: 'invalid_token'
      }
    end

    it 'does not create a new user' do
      expect { request }.to_not change(UserAccess::User, :count)
    end

    it 'does not create an outbox record' do
      expect { request }.to_not create_outbox_record(UserAccess::Outbox)
    end

    it 'renders the errors' do
      expect(request).to redirect_to root_path
    end
  end
end
