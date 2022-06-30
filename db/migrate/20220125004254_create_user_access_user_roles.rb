# typed: false
class CreateUserAccessUserRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_access_user_roles do |t|
      t.bigint :user_id, null: false, index: true
      t.integer :role_code, null: false, index: true

      t.timestamps
    end
  end
end
