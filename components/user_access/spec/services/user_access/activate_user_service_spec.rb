# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAccess::ActivateUserService do
  describe '#call' do
    let!(:user) do
      create(:user_access_user, status_code: :pending)
    end

    let(:event_payload) do
      {
        identifier: user.identifier,
        user_id: user.id,
        login: user.login,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
      }.stringify_keys
    end

    subject { described_class.new(event_payload).call }

    context 'when user activation succeeds' do
      it { is_expected.to be true }

      it 'updates the user status_code' do
        expect { subject }.to change { user.reload.status_code }.to('active')
      end

      it 'creates an outbox record' do
        expect { subject }.to create_outbox_record(UserAccess::Outbox).with_attributes lambda {
          {
            'event' => UserAccess::Events::USER_ACTIVATION_SUCCEEDED,
            'aggregate' => 'UserAccess::Member',
            'aggregate_identifier' => UserAccess::User.last.identifier
          }
        }
      end
    end

    context 'when user activation fails' do
      before do
        allow_any_instance_of(UserAccess::User).to receive(:update!).with(status_code: :active, outbox_event: UserAccess::Events::USER_ACTIVATION_SUCCEEDED).and_raise(ActiveRecord::RecordInvalid)
        allow_any_instance_of(UserAccess::User).to receive(:update!).with(status_code: :failed, outbox_event: UserAccess::Events::USER_ACTIVATION_FAILED, validate: false).and_call_original
      end

      it { is_expected.to be false }

      it 'updates the user status_code' do
        expect { subject }.to change { user.reload.status_code }.to('failed')
      end

      it 'creates an outbox record' do
        expect { subject }.to create_outbox_record(UserAccess::Outbox).with_attributes lambda {
          {
            'event' => UserAccess::Events::USER_ACTIVATION_FAILED,
            'aggregate' => 'UserAccess::Member',
            'aggregate_identifier' => UserAccess::User.last.identifier
          }
        }
      end
    end
  end
end
