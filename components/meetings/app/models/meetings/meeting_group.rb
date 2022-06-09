# == Schema Information
#
# Table name: meetings_meeting_groups
#
#  id                        :bigint           not null, primary key
#  description               :text
#  location_city             :string           not null
#  location_country_code     :string           not null
#  name                      :string           not null
#  payment_date_to           :date
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  creator_id                :bigint           not null
#  meeting_group_proposal_id :bigint           not null
#
# Indexes
#
#  index_meetings_meeting_groups_on_creator_id                 (creator_id)
#  index_meetings_meeting_groups_on_meeting_group_proposal_id  (meeting_group_proposal_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => meetings_members.id)
#  fk_rails_...  (meeting_group_proposal_id => meetings_meeting_group_proposals.id)
#
module Meetings
  class MeetingGroup < ApplicationRecord
  end
end
