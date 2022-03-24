# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Meetings::CreateMemberService do
  describe '#call' do
    subject { described_class.new(user_registration.id).call }

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
    end

    context 'when there are validation errors' do
      let!(:existing_member) { create(:meetings_member) }
      let(:user_registration) do
        create(:user_access_user_registration, status_code: :confirmed, confirmed_at: 1.day.ago,
                                               email: existing_member.email)
      end

      it 'raises a validation error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
