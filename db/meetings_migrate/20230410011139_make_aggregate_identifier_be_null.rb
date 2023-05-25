class MakeAggregateIdentifierBeNull < ActiveRecord::Migration[7.0]
  def up
    change_column :meetings_outboxes, :aggregate_identifier, :uuid, null: true
  end

  def down
    change_column :meetings_outboxes, :aggregate_identifier, :uuid, null: false
  end
end
