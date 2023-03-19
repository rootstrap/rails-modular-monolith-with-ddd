# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /users' do
  let(:request) do
    post user_registration_registration_path, params: params
  end

  context 'when params are valid' do
    let(:params) do
      {
        user: {
          login: Faker::Lorem.word,
          email: Faker::Internet.email,
          password: 'password123',
          password_confirmation: 'password123',
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name
        }
      }
    end

    it 'creates a new user registration' do
      expect { request }.to change(UserAccess::UserRegistration, :count).by(1)
    end

    it 'creates an outbox record' do
      expect { request }.to create_outbox_record(UserAccess::Outbox).with_attributes(
        'event' => UserAccess::Events::NEW_USER_REGISTERED
      ).and create_outbox_record(UserAccess::Outbox).with_attributes(
        'event' => UserAccess::Events::USER_REGISTRATION_UPDATED
      )
    end

    it 'enqueues the confirmation email' do
      expect { request }
        .to have_enqueued_job
        .on_queue('default')
        .with('Devise::Mailer', 'confirmation_instructions', 'deliver_now', args: anything)
    end

    it 'redirects to home page' do
      expect(request).to redirect_to('/')
    end
  end

  context 'when params are not valid' do
    let(:params) do
      {
        user: {
          login: Faker::Lorem.word,
          email: Faker::Internet.email,
          last_name: Faker::Name.last_name
        }
      }
    end

    it 'does not create a new user registration' do
      expect { request }.to_not change(UserAccess::UserRegistration, :count)
    end

    it 'renders the errors' do
      expect(request).to render_template(:new)
    end
  end
end
