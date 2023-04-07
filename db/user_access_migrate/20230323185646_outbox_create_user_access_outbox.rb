class OutboxCreateUserAccessOutbox < ActiveRecord::Migration[7.0]
  def change
    create_table :user_access_outboxes do |t|
      t.uuid :identifier, null: false, index: { unique: true }
      t.string :event, null: false
      t.jsonb :payload
      t.string :aggregate, null: false
      t.uuid :aggregate_identifier, null: false, index: true

      t.timestamps
    end
  end
end
