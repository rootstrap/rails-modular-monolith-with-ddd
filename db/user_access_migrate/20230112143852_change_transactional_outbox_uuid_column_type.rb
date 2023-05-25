class ChangeTransactionalOutboxUuidColumnType < ActiveRecord::Migration[7.0]
  def up
    change_column :transactional_outbox_outboxes, :aggregate_identifier, :string
  end

  def down
    change_column :transactional_outbox_outboxes, :aggregate_identifier, :uuid
  end
end
