# typed: false
class AddColumnsToUserAccessUser < ActiveRecord::Migration[6.1]
  def change
    add_column :user_access_users, :login, :string, null: false
    add_column :user_access_users, :is_active, :boolean, null: false
    add_column :user_access_users, :first_name, :string, null: false
    add_column :user_access_users, :last_name, :string, null: false
    add_column :user_access_users, :name, :string, null: false
  end
end
