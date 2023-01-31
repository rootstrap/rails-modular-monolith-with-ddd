class AddStatusToMeetingsConsumedMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings_consumed_messages, :status, :integer, default: 0, null: false
    add_index :meetings_consumed_messages, :status
  end
end
