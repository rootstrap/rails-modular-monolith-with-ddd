class DropIsActiveForUserAccessUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_access_users, :is_active
  end
end
