# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /users' do
  let(:password) { 'password123' }
  let(:password_confirmation) { password }
  let(:params) do
    {
      user: {
        login: Faker::Lorem.word,
        email: Faker::Internet.email,
        password: password,
        password_confirmation: password_confirmation,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      }
    }
  end

  subject do
    post user_registration_path, params: params
  end

  context 'when params are valid' do
    it 'creates a new user registration' do
      expect { subject }.to change(UserAccess::UserRegistration, :count).by(1)

      user_registration = UserAccess::UserRegistration.last
      expect(user_registration.status_code).to eq('waiting_for_confirmation')
    end

    it 'redirects to home page' do
      expect(subject).to redirect_to('/')
    end

    it 'encrypts the password' do
      subject

      user_registration = UserAccess::UserRegistration.last
      expect(user_registration.encrypted_password).to_not eq(password)
    end

    context 'when the password and password confirmation do not match' do
      let(:password_confirmation) { 'wrong password' }

      it 'does not create a new user registration' do
        expect { subject }.to_not change(UserAccess::UserRegistration, :count)
      end
    end
  end
end
