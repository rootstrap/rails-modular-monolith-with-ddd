# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Meetings::CreateMeetingGroupProposalService do
  let(:member) { create(:meetings_member) }
  let(:attributes) { attributes_for(:meetings_meeting_group_proposal) }

  describe '#call' do
    let(:service) { described_class.new(attributes, member.identifier) }

    context 'when valid' do
      it 'creates the meeting group proposal' do
        expect { service.call }.to change(Meetings::MeetingGroupProposal, :count).by (1)
      end

      it 'creates the meeting group proposal with a in_verification status' do
        service.call
        expect(Meetings::MeetingGroupProposal.last.status_code).to eq('in_verification')
      end

      it 'publishes the meeting_group_proposed_domain_event' do
        expect(ActiveSupport::Notifications).to receive(:instrument).with(
          'meeting_group_proposed_domain_event.meetings',
          {
            id: anything,
            **attributes
          }
        )
        service.call
      end
    end
  end
end
