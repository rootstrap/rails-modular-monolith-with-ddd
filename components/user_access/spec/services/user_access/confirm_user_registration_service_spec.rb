# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAccess::ConfirmUserRegistrationService do
  describe '#call' do
    let(:user_registration) do
      create(:user_access_user_registration, status_code: :waiting_for_confirmation)
    end

    subject { described_class.new(user_registration.confirmation_token).call }

    context 'when user can be confirmed' do
      it 'updates the user registration status code' do
        expect { subject }.to change { user_registration.reload.status_code }.to('confirmed')
      end

      it 'updates the user registration confirmed_at' do
        freeze_time do
          expect { subject }.to change { user_registration.reload.confirmed_at }.to(Time.current)
        end
      end

      it { is_expected.to be true }

      it 'triggers a user_registration_confirmed_domain_event' do
        freeze_time do
          user_registration_confirmed_domain_event = {
            user_registration_id: user_registration.id
          }

          expect(ActiveSupport::Notifications).to receive(:instrument).with(
            'user_registration_confirmed_domain_event.user_access',
            user_registration_confirmed_domain_event
          )

          subject
        end
      end
    end

    context 'when confirmation period has expired' do
      before do
        user_registration.update(confirmation_sent_at:
          Time.current - UserAccess::UserRegistration.confirm_within - 1.day
        )
      end

      it { is_expected.to be false }

      it 'does not update the user registration status' do
        expect { subject }.not_to change { user_registration.reload.status_code }
      end
    end

    context 'when user is already confirmed' do
      before do
        user_registration.update(confirmed_at: Time.current)
      end

      it { is_expected.to be false }

      it 'does not update the user registration status' do
        expect { subject }.not_to change { user_registration.reload.status_code }
      end
    end
  end
end
