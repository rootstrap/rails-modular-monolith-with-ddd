# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAccess::CreateUserService do
  describe '#call' do
    subject { described_class.new(user_registration.id).call }

    context 'when user registration is confirmed' do
      let(:user_registration) do
        create(:user_access_user_registration, status_code: :confirmed, confirmed_at: 1.day.ago)
      end

      let(:new_user) { UserAccess::User.last }

      it 'creates a user' do
        expect { subject }.to change(UserAccess::User, :count).by(1)
      end

      it 'creates a user with the registration attributes' do
        subject

        expect(new_user).to have_attributes(
          user_registration.slice(
            :login, :email, :encrypted_password,
            :first_name, :last_name, :name
          )
        )
      end

      it 'assigns the member role to the user' do
        subject

        expect(new_user.user_roles.size).to eq(1)
        expect(new_user.user_roles.pluck(:role_code)).to eq(['member'])
      end

      it 'creates a new user role' do
        expect { subject }.to change(UserAccess::UserRole, :count).by(1)
      end
    end

    context 'when user registration is not confirmed' do
      let(:user_registration) do
        create(:user_access_user_registration, status_code: :waiting_for_confirmation)
      end

      it 'does not create a user' do
        expect { subject }.not_to change(UserAccess::User, :count)
      end

      it 'does not create a new user role' do
        expect { subject }.not_to change(UserAccess::UserRole, :count)
      end
    end

    context 'when there are validation errors' do
      let!(:existing_user) { create(:user_access_user) }
      let(:user_registration) do
        create(:user_access_user_registration, status_code: :confirmed, confirmed_at: 1.day.ago,
                                               email: existing_user.email)
      end

      it 'raises a validation error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
