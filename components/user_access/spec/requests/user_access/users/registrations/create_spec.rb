# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /users' do
  subject do
    post user_registration_path, params: params
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
      expect { subject }.to change(UserAccess::UserRegistration, :count).by(1)
    end

    it 'redirects to home page' do
      expect(subject).to redirect_to('/')
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
      expect { subject }.to_not change(UserAccess::UserRegistration, :count)
    end

    it 'renders the errors' do
      expect(subject).to render_template(:new)
    end
  end
end
