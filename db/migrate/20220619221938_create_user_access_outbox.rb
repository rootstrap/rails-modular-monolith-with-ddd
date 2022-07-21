class CreateUserAccessOutbox < ActiveRecord::Migration[7.0]
  def change
    create_table :user_access_outboxes, id: :uuid do |t|
      t.string :event, null: false
      t.jsonb :payload
      t.string :aggregate, null: false
      t.uuid :aggregate_identifier, null: false

      t.timestamps
    end
  end
end
