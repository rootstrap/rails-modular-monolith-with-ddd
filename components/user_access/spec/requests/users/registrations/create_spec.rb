# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /users' do
  let(:password) { 'password123' }
  let(:params) do
    {
      user: attributes_for(:user_access_user).merge(password: password,
                                                    password_confirmation: password)
    }
  end

  subject do
    post user_registration_path, params: params
  end

  context 'when params are valid' do
    it 'creates a new user' do
      expect { subject }.to change(UserAccess::User, :count).by(1)
    end

    it 'redirects to home page' do
      expect(subject).to redirect_to('/')
    end
  end
end
