# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Meetings::AcceptMeetingGroupProposalService do
  let(:member) { create(:meetings_member) }
  let(:meeting_group_proposal) do
    create(:meetings_meeting_group_proposal, proposal_user_id: member.id)
  end
  let(:event_payload) { { meeting_group_proposal_id: meeting_group_proposal.id} }

  describe '#call' do
    subject { described_class.new(event_payload).call }

    context 'when valid' do
      it 'changes the meeting group proposal status' do
        expect { subject }.to change { meeting_group_proposal.reload.status_code }.to('accepted')
      end
    end
  end
end