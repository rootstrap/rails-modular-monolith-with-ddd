class CreateUserAccessUserRegistrations < ActiveRecord::Migration[6.1]
  def change
    create_table :user_access_user_registrations do |t|
      t.string :login, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :name, null: false
      t.integer :status, null: false
      t.datetime :registered_at, null: false
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
