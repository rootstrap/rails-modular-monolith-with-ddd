class CreateMeetingsMeetingGroupProposals < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings_meeting_group_proposals do |t|
      t.string :name, null: false
      t.text :description
      t.string :location_city, null: false
      t.string :location_country_code, null: false
      t.timestamp :proposal_date, null: false
      t.integer :status_code, null: false
      t.references :proposal_user, null: false, foreign_key: { to_table: :meetings_members }

      t.timestamps
    end
  end
end
