# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAccess::SendUserConfirmationEmailService do
  describe '#call' do
    subject { described_class.new({ user_registration_id: user_registration.id }).call }

    let(:user_registration) { create(:user_access_user_registration) }
    let(:token) { user_registration.confirmation_token }
    let(:email) { user_registration.email }
    let(:params) do
      {
        token: token,
        to: email
      }
    end

    it 'enqueues the confirmation email' do
      expect { subject }
        .to have_enqueued_job
        .on_queue('default')
        .with('Devise::Mailer', 'confirmation_instructions', 'deliver_now', args: [
          user_registration, user_registration.confirmation_token, anything
        ])
    end
  end
end
