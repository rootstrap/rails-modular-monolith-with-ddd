class AddIdentifierToUserRegistration < ActiveRecord::Migration[7.0]
  def change
    add_column :user_access_user_registrations, :identifier, :uuid, null: false
    add_index :user_access_user_registrations, :identifier, unique: true
  end
end
