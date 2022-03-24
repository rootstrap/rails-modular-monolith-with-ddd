class CreateMeetingsMeetingGroupProposals < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings_meeting_group_proposals do |t|
      t.string :name, null: false
      t.text :description
      t.string :location_city, null: false
      t.string :location_country_code, null: false
      t.bigint :proposal_user_id, null: false
      t.timestamp :proposal_date, null: false
      t.integer :status_code, null: false

      t.timestamps
    end
  end
end
