class RemoveUserAccessOutboxes < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_access_outboxes do |t|
      t.uuid :identifier, null: false, index: { unique: true }
      t.string :event, null: false
      t.jsonb :payload
      t.string :aggregate, null: false
      t.uuid :aggregate_identifier, null: false

      t.timestamps
    end
  end
end
