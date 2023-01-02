class AddStatusToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :user_access_users, :status_code, :integer, default: 0
  end
end
