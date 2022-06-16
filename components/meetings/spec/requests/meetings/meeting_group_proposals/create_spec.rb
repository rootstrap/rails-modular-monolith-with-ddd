# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /meetings/meeting_group_proposals' do
  let(:user) { create(:user_access_user) }

  before do
    sign_in user
  end

  subject do
    post meetings_meeting_group_proposals_path, params: params
  end

  context 'when a member exists' do
    let!(:member) { create(:meetings_member, identifier: user.identifier) }

    context 'when params are valid' do
      let(:params) do
        {
          meeting_group_proposal: {
            description: 'Random description',
            location_city: 'Random city',
            location_country_code: 'Random country code',
            name: 'Random name'
          }
        }
      end

      it 'creates a new meeting group proposal' do
        expect { subject }.to change(Meetings::MeetingGroupProposal, :count).by(1)
      end
    end

    context 'when params are invalid' do
      let(:params) do
        {
          meeting_group_proposal: {
            description: ''
          }
        }
      end

      xit 'does not create a new meeting group proposal' do
        # TODO: fix this test
        expect { subject }.not_to change(Meetings::MeetingGroupProposal, :count)
      end
    end
  end

  context 'when a member does not exist' do
    context 'when params are valid' do
      let(:params) do
        {
          meeting_group_proposal: {
            description: 'Random description',
            location_city: 'Random city',
            location_country_code: 'Random country code',
            name: 'Random name'
          }
        }
      end

      it 'raises an error' do
        expect { subject }.to raise_error
      end
    end
  end
end
