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

      it 'creates an outbox record' do
        expect { subject }.to create_transactional_outbox_record.with_attributes lambda {
          {
            'event' => Meetings::Events::MEETING_GROUP_PROPOSED,
            'aggregate' => 'Meetings::MeetingGroupProposal',
            'aggregate_identifier' => Meetings::MeetingGroupProposal.last.id.to_s
          }
        }
      end
    end
  end
end
