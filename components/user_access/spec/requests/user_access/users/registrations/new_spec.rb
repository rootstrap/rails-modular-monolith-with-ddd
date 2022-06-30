# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /users/sign_up' do
  subject do
    get new_user_registration_registration_path
  end

  it 'render the correct template' do
    expect(subject).to render_template(:new)
  end
end
