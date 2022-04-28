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

    context 'when it is valid' do
      it 'changes the meeting group proposal status' do
        expect { subject }.to change { meeting_group_proposal.reload.status_code }.to('accepted')
      end

      it 'creates the meeting group' do
        expect { subject }.to change(Meetings::MeetingGroup, :count).by(1)
      end

      it 'creates the meeting group proposal with the correct attributes' do
        subject        

        expect(Meetings::MeetingGroup.last).to have_attributes(
          description: meeting_group_proposal.description,
          name: meeting_group_proposal.name,
          location_city: meeting_group_proposal.location_city,
          location_country_code: meeting_group_proposal.location_country_code,
          creator_id: meeting_group_proposal.proposal_user_id,
          meeting_group_proposal_id: meeting_group_proposal.id
        )
      end
    end

    context 'when it is invalid' do
      let(:meeting_group_proposal) do
        create(:meetings_meeting_group_proposal, :accepted, proposal_user_id: member.id)
      end

      it 'does not create the meeting group' do
        expect { subject }.not_to change(Meetings::MeetingGroup, :count)
      end
    end
  end
end