class RemoveConfirmationColumnsFromUserAccessUser < ActiveRecord::Migration[6.1]
  def change
    ## Confirmable
    remove_column :user_access_users, :confirmation_token, :string
    remove_column :user_access_users, :confirmed_at, :datetime
    remove_column :user_access_users, :confirmation_sent_at, :datetime
    remove_column :user_access_users, :unconfirmed_email, :string
  end
end
