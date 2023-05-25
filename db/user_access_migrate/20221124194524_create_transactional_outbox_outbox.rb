class CreateTransactionalOutboxOutbox < ActiveRecord::Migration[7.0]
  def change
    create_table :transactional_outbox_outboxes do |t|
      t.string :aggregate, null: false
      t.uuid :aggregate_identifier, null: false
      t.string :event, null: false
      t.uuid :identifier, null: false, index: true
      t.jsonb :payload

      t.timestamps
    end
  end
end
