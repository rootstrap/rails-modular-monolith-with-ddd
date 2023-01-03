# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Meetings::CreateMemberService do
  describe '#call' do
    subject { described_class.new(event_payload).call }

    let(:event_payload) do
      {
        identifier: user_registration.identifier,
        user_registration_id: user_registration.id,
        login: user_registration.login,
        email: user_registration.email,
        first_name: user_registration.first_name,
        last_name: user_registration.last_name,
        name: "#{user_registration.first_name} #{user_registration.last_name}",
      }.stringify_keys
    end

    context 'when user registration is confirmed' do
      let(:user_registration) do
        create(:user_access_user_registration, status_code: :confirmed, confirmed_at: 1.day.ago)
      end

      let(:new_member) { Meetings::Member.last }

      it 'creates a member' do
        expect { subject }.to change(Meetings::Member, :count).by(1)
      end

      it 'creates a member with the registration attributes' do
        subject

        expect(new_member).to have_attributes(
          user_registration.slice(
            :login, :email,
            :first_name, :last_name, :name
          )
        )
      end

      it 'creates an outbox record' do
        expect { subject }.to change(Meetings::Outbox, :count).by(1)
        member = Meetings::Member.last
        outbox = Meetings::Outbox.last
        expect(outbox.event).to eq(Meetings::Events::CREATED_MEMBER_SUCCESSFULLY)
        expect(outbox.aggregate).to eq('Meetings::Member')
        expect(outbox.aggregate_identifier).to eq(member.identifier)
      end
    end

    context 'when there are validation errors' do
      let!(:existing_member) { create(:meetings_member) }
      let(:user_registration) do
        create(:user_access_user_registration, status_code: :confirmed, confirmed_at: 1.day.ago,
                                               email: existing_member.email)
      end

      it 'does not create a new member' do
        expect { subject }.to_not change(Meetings::Member, :count)
      end

      it 'does not create an outbox record' do
        expect { subject }.to_not change(Meetings::Outbox, :count)
      end

      it 'logs error' do
        expect(Rails.logger).to receive(:error)
        subject
      end
    end
  end
end
