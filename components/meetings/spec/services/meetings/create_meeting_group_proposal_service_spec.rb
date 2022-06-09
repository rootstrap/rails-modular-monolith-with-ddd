# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Meetings::CreateMeetingGroupProposalService do
  let(:member) { create(:meetings_member) }
  let(:attributes) do
    attributes_for(:meetings_meeting_group_proposal, proposal_user_id: member.id,
                                                     status_code: 'in_verification')
  end

  before do
    freeze_time
  end

  describe '#call' do
    subject { described_class.new(attributes, member.identifier).call }

    context 'when valid' do
      it 'creates the meeting group proposal' do
        expect { subject }.to change(Meetings::MeetingGroupProposal, :count).by(1)
      end

      it 'creates the meeting group proposal with a in_verification status' do
        subject
        expect(Meetings::MeetingGroupProposal.last.status_code).to eq('in_verification')
      end

      it 'publishes the meeting_group_proposed_domain_event' do
        allow(ActiveSupport::Notifications).to receive(:instrument).and_call_original
        expect(ActiveSupport::Notifications).to receive(:instrument).with(
          'meeting_group_proposed_domain_event.meetings',
          attributes.merge(
            id: anything
          )
        )
        subject
      end
    end
  end
end
