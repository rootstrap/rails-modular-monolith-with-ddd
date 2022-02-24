# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAccess::ConfirmUserRegistrationService do
  describe '#call' do
    let(:user_registration) { create(:user_access_user_registration) }

    subject { described_class.new(user_registration.confirmation_token).call }

    context 'when user can be confirmed' do
      
    end


    context 'when confirmation period has expired' do
      
    end

    context 'when user is already confirmed' do
    end
  end
end
