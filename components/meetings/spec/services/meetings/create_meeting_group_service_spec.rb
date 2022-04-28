# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Meetings::CreateMeetingGroupService do
  let(:member) { create(:meetings_member) }
  let(:meeting_group_proposal) { create(:meetings_meeting_group_proposal, proposal_user_id: member.id) }
  let(:attributes) do
    attributes_for(:meetings_meeting_group, creator_id: member.id, 
                                            meeting_group_proposal_id: meeting_group_proposal.id)
  end

  describe '#call' do
    subject { described_class.new(attributes).call }

    context 'when valid' do
      it 'creates the meeting group' do
        expect { subject }.to change(Meetings::MeetingGroupProposal, :count).by(1)
      end
    end
  end
end