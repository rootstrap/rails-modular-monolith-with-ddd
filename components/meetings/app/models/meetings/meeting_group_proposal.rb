# == Schema Information
#
# Table name: meetings_meeting_group_proposals
#
#  id                    :bigint           not null, primary key
#  description           :text
#  location_city         :string           not null
#  location_country_code :string           not null
#  name                  :string           not null
#  proposal_date         :datetime         not null
#  status_code           :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  proposal_user_id      :bigint           not null
#
# Indexes
#
#  index_meetings_meeting_group_proposals_on_proposal_user_id  (proposal_user_id)
#
# Foreign Keys
#
#  fk_rails_...  (proposal_user_id => meetings_members.id)
#
module Meetings
  class MeetingGroupProposal < ApplicationRecord
    include TransactionalOutbox::Outboxable

    enum status_code: {
      in_verification: 0,
      accepted: 1
    }
  end
end
