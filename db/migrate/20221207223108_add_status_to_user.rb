class AddStatusToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :user_access_users, :status, :integer, default: 0
  end
end
