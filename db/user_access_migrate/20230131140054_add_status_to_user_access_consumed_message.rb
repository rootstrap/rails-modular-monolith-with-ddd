class AddStatusToUserAccessConsumedMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :user_access_consumed_messages, :status, :integer, default: 0, null: false
    add_index :user_access_consumed_messages, :status
  end
end
