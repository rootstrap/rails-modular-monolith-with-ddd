class CreateUserAccessConsumedMessage < ActiveRecord::Migration[7.0]
  def change
    create_table :user_access_consumed_messages do |t|
      t.uuid :event_id
      t.string :aggregate

      t.timestamps
    end
  end
end
