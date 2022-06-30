# typed: false
class AddConfirmationColumnsToUserAccessUserRegistration < ActiveRecord::Migration[6.1]
  def change
    ## Confirmable
    add_column :user_access_user_registrations, :confirmation_token, :string
    add_column :user_access_user_registrations, :confirmation_sent_at, :datetime
    add_column :user_access_user_registrations, :unconfirmed_email, :string
  end
end
