# typed: false
class CreateMeetingsMeetingGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings_meeting_groups do |t|
      t.string :name, null: false
      t.text :description
      t.string :location_city, null: false
      t.string :location_country_code, null: false
      t.references :creator, null: false, foreign_key: { to_table: :meetings_members }
      t.references :meeting_group_proposal, null: false, foreign_key: { to_table: :meetings_meeting_group_proposals }
      t.date :payment_date_to

      t.timestamps
    end
  end
end
