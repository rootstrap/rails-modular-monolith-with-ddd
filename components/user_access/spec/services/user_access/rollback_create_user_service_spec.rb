# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAccess::RollbackCreateUserService do
  describe '#call' do
    subject { described_class.new(user_registration.as_json).call }

    let(:user_registration) do
      create(:user_access_user_registration, status_code: :confirmed, confirmed_at: 1.day.ago)
    end

    let!(:user) { create(:user_access_user, identifier: user_registration.identifier) }

    context 'with a successful rollback' do
      it 'destroys the user' do
        expect { subject }.to change(UserAccess::User, :count).by(-1)
      end

      it 'unconfirms user_registration' do
        expect { subject }.to change { user_registration.reload.status_code }.from('confirmed').to('waiting_for_confirmation')
      end
    end

    context 'when there are validation errors' do
      before { allow_any_instance_of(UserAccess::User).to receive(:destroy!).and_raise(ActiveRecord::RecordNotDestroyed) }

      it 'rollbacks the transaction' do
        expect { subject }.to not_change(UserAccess::User, :count)
          .and not_change { user_registration.reload.status_code }
      end

      it 'logs error' do
        expect(Rails.logger).to receive(:error)
        subject
      end
    end
  end
end
