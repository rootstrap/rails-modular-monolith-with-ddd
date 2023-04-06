class AddIdentifierToMeetingsMeetingGroupProposal < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings_meeting_group_proposals, :identifier, :uuid, null: false
  end
end
