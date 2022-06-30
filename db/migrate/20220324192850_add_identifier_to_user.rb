# typed: false
class AddIdentifierToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :user_access_users, :identifier, :uuid, null: false
    add_index :user_access_users, :identifier, unique: true
  end
end
